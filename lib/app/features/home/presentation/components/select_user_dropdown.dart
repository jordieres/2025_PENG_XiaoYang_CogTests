import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/routes/app_route_observer.dart';
import '../../../user/domain/entities/user_profile.dart';
import '../controllers/select_user_profile_controller.dart';

class SelectUserDropdown extends StatefulWidget {
  const SelectUserDropdown({super.key});

  @override
  State<StatefulWidget> createState() => SelectUserDropdownState();
}

class SelectUserDropdownState extends State<SelectUserDropdown> {
  Worker? _routeObserverWorker;
  String? selectedUserId;
  late SelectUserController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<SelectUserController>();
    _routeChangeObserver();
  }

  void _routeChangeObserver() {
    _routeObserverWorker = ever(appRouteObserver.currentRouteName, (routeName) {
      if (routeName == Routes.home) {
        _controller.loadUserIds();
        _controller.loadCurrentProfile();
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
        Obx(() {
          if (_controller.isLoading.value) {
            return CircularProgressIndicator();
          } else if (_controller.currentProfile.value != null) {
            final profile = _controller.currentProfile.value!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nickname: ${profile.nickname}'),
                Text('ID: ${profile.userId}'),
                Text(
                    'Sexo: ${profile.sex == Sex.male ? 'Masculino' : 'Femenino'}'),
                Text(
                    'Fecha de nacimiento: ${profile.birthDate.toIso8601String().split('T')[0]}'),
              ],
            );
          } else {
            return Text('No hay perfil de usuario seleccionado');
          }
        }),
        SizedBox(height: 20),
        Obx(() => DropdownButton<String>(
              hint: Text('Seleccionar usuario'),
              value: selectedUserId,
              onChanged: (String? newValue) async {
                if (newValue != null) {
                  await _controller.setCurrentProfile(newValue);
                  setState(() {
                    selectedUserId = newValue;
                  });
                }
              },
              items: _controller.userIds
                  .map<DropdownMenuItem<String>>((String userId) {
                return DropdownMenuItem<String>(
                  value: userId,
                  child: FutureBuilder<UserProfile?>(
                    future: _controller.getProfileByUserId(userId),
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
            )),
      ],
    );
  }
}
