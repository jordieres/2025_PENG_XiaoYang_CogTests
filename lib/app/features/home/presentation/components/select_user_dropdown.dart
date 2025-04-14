import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/routes/app_route_observer.dart';
import '../../../../utils/services/user_data_base_helper.dart';
import '../../../user/data/datasources/user_profle_data_soruce.dart';
import '../../../user/data/model/user_profile_model.dart';
import '../../../user/domain/entities/user_profile.dart';

class SelectUserDropdown extends StatefulWidget {
  const SelectUserDropdown({super.key});

  @override
  State<StatefulWidget> createState() => SelectUserDropdownState();
}

class SelectUserDropdownState extends State<SelectUserDropdown> {
  Worker? _routeObserverWorker;
  String? selectedUserId;
  List<String> userIds = [];
  late UserProfileDataSourceImpl userLocalDataSource;
  bool needsRefresh = false;

  @override
  void initState() {
    super.initState();
    userLocalDataSource =
        UserProfileDataSourceImpl(databaseHelper: UserDatabaseHelper());
    loadUserIds();
    _routeChangeObserver();
  }

  Future<void> loadUserIds() async {
    final ids = await userLocalDataSource.getAllUserId();
    setState(() {
      userIds = ids;
    });
  }

  Future<UserProfileModel?> _loadCurrentProfile() async {
    return await userLocalDataSource.getCurrentProfile();
  }

  void _routeChangeObserver() {
    _routeObserverWorker = ever(appRouteObserver.currentRouteName, (routeName) {
      if (routeName == Routes.home) {
        loadUserIds();
      }
    });
  }

  @override
  void dispose() {
    _routeObserverWorker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<UserProfileModel?>(
          future: _loadCurrentProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data != null) {
              final profile = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nickname: ${profile.nickname}'),
                  Text('ID: ${profile.userId}'),
                  Text(
                      'Sexo: ${profile.sex == Sex.male ? 'Masculino' : 'Femenino'}'),
                  Text(
                      'Fecha de nacimiento: ${profile.birthDate.toIso8601String().split('T')[0]}'),
                  Text(
                      'Nivel educativo: ${_getEducationLevelText(profile.educationLevel)}'),
                ],
              );
            } else {
              return Text('No hay perfil de usuario seleccionado');
            }
          },
        ),
        SizedBox(height: 20),
        DropdownButton<String>(
          hint: Text('Seleccionar usuario'),
          value: selectedUserId,
          onChanged: (String? newValue) async {
            if (newValue != null) {
              await userLocalDataSource.setCurrentProfile(newValue);
              setState(() {
                selectedUserId = newValue;
                needsRefresh = !needsRefresh;
              });
            }
          },
          items: userIds.map<DropdownMenuItem<String>>((String userId) {
            return DropdownMenuItem<String>(
              value: userId,
              child: FutureBuilder<UserProfileModel?>(
                future: userLocalDataSource.getProfileByUserId(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Cargando...');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return Text(snapshot.data!.nickname);
                  } else {
                    return Text(userId);
                  }
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getEducationLevelText(EducationLevel level) {
    switch (level) {
      case EducationLevel.primary:
        return 'Estudios Primarios';
      case EducationLevel.secondary:
        return 'Estudios Secundarios';
      case EducationLevel.graduate:
        return 'Grado Universitario';
      case EducationLevel.master:
        return 'Máster Universitario';
      case EducationLevel.doctorate:
        return 'Doctorado';
      default:
        return '';
    }
  }
}
