import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/features/user/presentation/screen/user_screen_base.dart';

import '../../../../config/themes/AppColors.dart';
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

class _RegisterUserScreenState extends RegisterUserScreenBaseState<RegisterUserScreen> {
  @override
  String getScreenTitle() {
    return TMTRegisterUserText.title.tr;
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
  void initState() {
    super.initState();
    nicknameController.addListener(_onNicknameChanged);
  }

  @override
  void dispose() {
    nicknameController.removeListener(_onNicknameChanged);
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