import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/features/user/presentation/screen/user_screen_base.dart';

import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../shared_components/custom_secondary_button.dart';
import '../../../../utils/ui/ui_utils.dart';
import '../../domain/entities/user_profile.dart';

class RegisterUserScreen extends RegisterUserScreenBase {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState
    extends RegisterUserScreenBaseState<RegisterUserScreen> {
  bool isNicknameExists = false;
  String? nicknameErrorText;

  bool nicknameVisited = false;
  bool sexVisited = false;
  bool birthDateVisited = false;
  bool educationLevelVisited = false;
  bool formSubmitted = false;

  @override
  void initState() {
    super.initState();
    nicknameController.addListener(_onNicknameChanged);
    nicknameFocusNode.addListener(_onNicknameFocusChange);
    birthDateFocusNode.addListener(_onBirthDateFocusChange);
    educationLevelFocusNode.addListener(_onEducationLevelFocusChange);
  }

  @override
  void dispose() {
    nicknameController.removeListener(_onNicknameChanged);
    nicknameFocusNode.removeListener(_onNicknameFocusChange);
    birthDateFocusNode.removeListener(_onBirthDateFocusChange);
    educationLevelFocusNode.removeListener(_onEducationLevelFocusChange);
    super.dispose();
  }

  void _onNicknameChanged() {
    if (nicknameController.text.isEmpty) {
      if (isNicknameExists) {
        setState(() {
          isNicknameExists = false;
          nicknameErrorText = null;
        });
      }
      if (!nicknameVisited) {
        setState(() {
          nicknameVisited = true;
        });
      }
    }
  }

  void _onNicknameFocusChange() {
    if (nicknameFocusNode.hasFocus) {
      formKey.currentState?.validate();
    }
  }

  void _onBirthDateFocusChange() {
    if (birthDateFocusNode.hasFocus) {
      formKey.currentState?.validate();
    }
  }

  void _onEducationLevelFocusChange() {
    if (educationLevelFocusNode.hasFocus) {
      formKey.currentState?.validate();
    }
  }

  @override
  bool get isFormComplete {
    return nicknameController.text.trim().isNotEmpty &&
        selectedBirthDate != null &&
        selectedSex != null &&
        selectedEducationLevel != null &&
        !isNicknameExists;
  }

  @override
  String getScreenTitle() {
    return TMTRegisterUserText.title.tr;
  }

  @override
  String? validateNicknameField(String? value) {
    if ((nicknameVisited || formSubmitted)) {
      if (nicknameFocusNode.hasFocus) {
        return null;
      }
      if (value == null || value.isEmpty) {
        return TMTRegisterUserText.nicknameError.tr;
      }
      if (isNicknameExists) {
        return nicknameErrorText;
      }
    }
    return null;
  }

  @override
  void onNicknameFieldTap() {
    setState(() => nicknameVisited = true);
  }

  @override
  void onNicknameFieldChanged(String value) {
    setState(() {
      nicknameVisited = true;
      isNicknameExists = false;
      nicknameErrorText = null;
    });
    formKey.currentState?.validate();
  }

  @override
  Widget buildSexValidationError() {
    if ((sexVisited || formSubmitted) && selectedSex == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 0, left: 12.0, bottom: 8.0),
        child: Text(
          TMTRegisterUserText.sexError.tr,
          style: TextStyleBase.bodyS.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    }
    return SizedBox.shrink();
  }

  @override
  void onSexChanged(Sex? value) {
    setState(() {
      selectedSex = value;
      sexVisited = true;
      nicknameVisited = true;
    });
    formKey.currentState?.validate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateFormHeight();
    });
  }

  @override
  String? validateBirthDateField(String? value) {
    if ((birthDateVisited || formSubmitted)) {
      if (birthDateFocusNode.hasFocus) {
        return null;
      }
      if (selectedBirthDate == null) {
        return TMTRegisterUserText.birthDateError.tr;
      }
    }
    return null;
  }

  @override
  void onDateSelected(DateTime date) {
    setState(() {
      birthDateVisited = true;
      nicknameVisited = true;
      sexVisited = true;
    });
    formKey.currentState?.validate();
  }

  @override
  void onEducationLevelChanged(EducationLevel? value) {
    setState(() {
      selectedEducationLevel = value;
      educationLevelVisited = true;
      nicknameVisited = true;
      sexVisited = true;
      birthDateVisited = true;
    });
    formKey.currentState?.validate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateFormHeight();
    });
  }

  @override
  String? validateEducationLevelField(EducationLevel? value) {
    if ((educationLevelVisited || formSubmitted)) {
      if (educationLevelFocusNode.hasFocus) {
        return null;
      }
      if (value == null) {
        return TMTRegisterUserText.educationError.tr;
      }
    }
    return null;
  }

  Future<void> handleSave() async {
    FocusScope.of(context).unfocus();

    setState(() {
      formSubmitted = true;
      nicknameVisited = true;
      sexVisited = true;
      birthDateVisited = true;
      educationLevelVisited = true;
    });

    final isValid = formKey.currentState!.validate();
    final nickname = nicknameController.text.trim();

    if (nickname.isEmpty) {
      if (mounted) {
        AppSnackbar.showCustomSnackbar(
          context,
          TMTRegisterUserText.nicknameError.tr,
          backgroundColor: AppColors.mainRed.withAlpha(204),
        );
      }
      return;
    }

    if (selectedSex == null ||
        selectedBirthDate == null ||
        selectedEducationLevel == null) {
      setState(() {});
    }

    if (!isValid ||
        selectedSex == null ||
        selectedBirthDate == null ||
        selectedEducationLevel == null) {
      AppSnackbar.showCustomSnackbar(
        context,
        TMTRegisterUserText.formError.tr,
        backgroundColor: AppColors.mainRed.withAlpha(204),
      );
      return;
    }

    final existingProfile = await controller.getProfileByNickname(nickname);
    if (existingProfile != null) {
      setState(() {
        isNicknameExists = true;
        nicknameErrorText = TMTRegisterUserText.nicknameExistsError.tr;
      });
      formKey.currentState?.validate();
      if (mounted) {
        AppSnackbar.showCustomSnackbar(
          context,
          TMTRegisterUserText.nicknameExistsError.tr,
          backgroundColor: AppColors.mainRed.withAlpha(204),
        );
      }
      return;
    }

    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      final newUserProfile = UserProfile(
        nickname: nicknameController.text.trim(),
        sex: selectedSex!,
        birthDate: selectedBirthDate!,
        educationLevel: selectedEducationLevel!,
      );

      await controller.saveProfile(newUserProfile);
      await controller.loadProfiles();
      Get.back();
      if (mounted) {
        AppSnackbar.showCustomSnackbar(
          context,
          TMTRegisterUserText.saveSuccess.tr,
        );
      }
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showCustomSnackbar(
        context,
        TMTRegisterUserText.saveError.tr,
        backgroundColor: AppColors.mainRed.withAlpha(204),
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
  Widget buildActionButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading)
          Center(child: CircularProgressIndicator())
        else ...[
          Center(
            child: CustomPrimaryButton(
              text: TMTRegisterUserText.saveButton.tr,
              onPressed: handleSave,
              isEnabled: isFormComplete && !isLoading,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: CustomSecondaryButton(
              text: TMTRegisterUserText.cancelButton.tr,
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.back();
              },
            ),
          ),
        ],
      ],
    );
  }
}
