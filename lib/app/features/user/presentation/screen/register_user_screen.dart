import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/input_decoration.dart';
import '../../domain/entities/user_profile.dart';
import '../contoller/user_profile_controller.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../shared_components/custom_secondary_button.dart';
import '../../../../utils/helpers/app_helpers.dart';

class RegisterUserScreen extends StatefulWidget {
  RegisterUserScreen({Key? key}) : super(key: key);

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nicknameController = TextEditingController();

  Sex? selectedSex;
  DateTime? selectedBirthDate;
  EducationLevel? selectedEducationLevel;

  bool isLoading = false;

  bool _nicknameVisited = false;
  bool _sexVisited = false;
  bool _birthDateVisited = false;
  bool _educationLevelVisited = false;
  bool _formSubmitted = false;

  late UserProfileController controller;

  final TextStyle _labelStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    super.initState();
    controller = Get.find<UserProfileController>();
  }

  @override
  void dispose() {
    nicknameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    setState(() {
      _birthDateVisited = true;
      _nicknameVisited = true;
      _sexVisited = true;
    });

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: Get.locale,
      helpText: 'Seleccionar fecha de nacimiento',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
    );
    if (picked != null && picked != selectedBirthDate) {
      setState(() {
        selectedBirthDate = picked;
      });
    }

    _formKey.currentState?.validate();
  }

  bool get isFormComplete {
    return nicknameController.text.isNotEmpty &&
        selectedBirthDate != null &&
        selectedSex != null &&
        selectedEducationLevel != null;
  }

  void saveUser() {
    setState(() {
      _formSubmitted = true;
      _nicknameVisited = true;
      _sexVisited = true;
      _birthDateVisited = true;
      _educationLevelVisited = true;
    });

    final isValid = _formKey.currentState!.validate();

    if (selectedSex == null ||
        selectedBirthDate == null ||
        selectedEducationLevel == null) {
      setState(() {});
    }

    if (!isValid ||
        selectedSex == null ||
        selectedBirthDate == null ||
        selectedEducationLevel == null) {
      Get.snackbar(
        'Formulario incompleto',
        'Por favor, rellena todos los campos marcados.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        margin: EdgeInsets.all(8),
      );
      return;
    }

    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      final newUserProfile = UserProfile(
        nickname: nicknameController.text,
        sex: selectedSex!,
        birthDate: selectedBirthDate!,
        educationLevel: selectedEducationLevel!,
      );

      controller.saveProfile(newUserProfile);

      Get.back();
    } catch (e) {
      if (!mounted) return;
      Get.snackbar(
        'Error',
        'Error al guardar el perfil: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        margin: EdgeInsets.all(8),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = Get.locale?.toString() ?? 'en_US';
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final isDarkMode = Get.isDarkMode;
    final appBar = CustomAppBar(title: 'Mis Datos');
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    final GlobalKey formKey = GlobalKey();

    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: isLandscape || DeviceHelper.isTablet
                    ? mediaQuery.size.width * 0.8
                    : null,
                padding: const EdgeInsets.fromLTRB(16.0, 62.0, 16.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      key: formKey,
                      child: _buildFormFields(
                          currentLocale, isLandscape, isDarkMode),
                    ),
                    FutureBuilder(
                      future: Future.delayed(Duration(milliseconds: 50), () {
                        if (formKey.currentContext != null) {
                          final RenderBox box = formKey.currentContext!
                              .findRenderObject() as RenderBox;
                          final formHeight = box.size.height;
                          final remainingSpace =
                              availableHeight - formHeight - 62.0 - 16.0;
                          return remainingSpace > 0 ? remainingSpace / 2 : 32.0;
                        }
                        return 32.0;
                      }),
                      builder: (context, snapshot) {
                        final spacing = snapshot.data ?? 32.0;
                        return SizedBox(height: spacing);
                      },
                    ),
                    _buildActionButtons(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFormFields(
      String currentLocale, bool isLandscape, bool isDarkMode) {
    final primaryColor =
        isDarkMode ? AppColors.primaryBlueDark : AppColors.primaryBlue;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Apodo', style: _labelStyle),
          const SizedBox(height: 8),
          TextFormField(
            controller: nicknameController,
            decoration: CustomInputDecoration.commonInputDecoration.copyWith(
              hintText: 'Introduce un apodo',
            ),
            validator: (value) {
              if (_nicknameVisited || _formSubmitted) {
                if (value == null || value.isEmpty) {
                  return 'Por favor introduce un apodo';
                }
              }
              return null;
            },
            onTap: () => setState(() => _nicknameVisited = true),
            onChanged: (value) {
              setState(() => _nicknameVisited = true);
            },
            style: CustomInputDecoration.textInputStyle,
          ),
          const SizedBox(height: 24),
          Text('Sexo', style: _labelStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: RadioListTile<Sex>(
                  title: const Text('Masculino'),
                  value: Sex.male,
                  groupValue: selectedSex,
                  activeColor: primaryColor,
                  onChanged: (Sex? value) {
                    setState(() {
                      selectedSex = value;
                      _sexVisited = true;
                      _nicknameVisited = true;
                    });
                    _formKey.currentState?.validate();
                  },
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 150,
                child: RadioListTile<Sex>(
                  title: const Text('Femenino'),
                  value: Sex.female,
                  groupValue: selectedSex,
                  activeColor: primaryColor,
                  onChanged: (Sex? value) {
                    setState(() {
                      selectedSex = value;
                      _sexVisited = true;
                      _nicknameVisited = true;
                    });
                    _formKey.currentState?.validate();
                  },
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
          if ((_sexVisited || _formSubmitted) && selectedSex == null)
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 12.0, bottom: 8.0),
              child: Text(
                'Por favor selecciona un sexo',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.error, fontSize: 12),
              ),
            ),
          const SizedBox(height: 16),
          Text('Fecha de nacimiento', style: _labelStyle),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => _selectDate(context),
            child: InputDecorator(
                decoration:
                    CustomInputDecoration.commonInputDecoration.copyWith(
                  errorText: (_birthDateVisited || _formSubmitted) &&
                          selectedBirthDate == null
                      ? 'Por favor selecciona una fecha'
                      : null,
                  errorMaxLines: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedBirthDate == null
                          ? 'Seleccionar fecha'
                          : DateFormat.yMd(currentLocale)
                              .format(selectedBirthDate!),
                      style: selectedBirthDate == null
                          ? CustomInputDecoration
                              .commonInputDecoration.hintStyle
                          : Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Color(0xFF1A1A1A)),
                    ),
                    const Icon(Icons.calendar_today, color: Color(0xFF8F9098)),
                  ],
                )),
          ),
          const SizedBox(height: 24),
          Text('Nivel de estudios', style: _labelStyle),
          const SizedBox(height: 8),
          DropdownButtonFormField<EducationLevel>(
            value: selectedEducationLevel,
            decoration: CustomInputDecoration.commonInputDecoration.copyWith(),
            hint: Text(
              'Seleccionar nivel de estudios',
              style: CustomInputDecoration.commonInputDecoration.hintStyle,
            ),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Color(0xFF1A1A1A)),
            items: EducationLevel.values
                .map((level) => DropdownMenuItem(
                      value: level,
                      child: Text(getEducationLevelText(level)),
                    ))
                .toList(),
            onChanged: (EducationLevel? value) {
              setState(() {
                selectedEducationLevel = value;
                _educationLevelVisited = true;
                _nicknameVisited = true;
                _sexVisited = true;
                _birthDateVisited = true;
              });
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if ((_educationLevelVisited || _formSubmitted) && value == null) {
                return 'Por favor selecciona un nivel de estudios';
              }
              return null;
            },
            isExpanded: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading)
          Center(child: CircularProgressIndicator())
        else ...[
          Center(
            child: CustomPrimaryButton(
              text: 'Guardar',
              onPressed: saveUser,
              isEnabled: isFormComplete && !isLoading,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: CustomSecondaryButton(
              text: 'Cancelar',
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ],
    );
  }

  String getEducationLevelText(EducationLevel level) {
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
