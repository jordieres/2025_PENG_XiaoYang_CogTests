import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:msdtmt/app/config/themes/app_text_style_base.dart';
import 'package:msdtmt/app/shared_components/custom_dialog.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../shared_components/custom_secondary_button.dart';
import '../../../../utils/ui/ui_utils.dart';
import '../../domain/entities/user_profile.dart';
import '../screen/user_screen_base.dart';

class CurrentUserDataScreen extends RegisterUserScreenBase {
  const CurrentUserDataScreen({super.key});

  @override
  State<CurrentUserDataScreen> createState() => _CurrentUserDataScreenState();
}

class _CurrentUserDataScreenState
    extends RegisterUserScreenBaseState<CurrentUserDataScreen> {
  @override
  bool get isReadOnly => true;

  UserProfile? currentProfile;
  bool isLoadingProfile = true;

  bool isFormReady = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentProfile();
  }

  @override
  void updateFormHeight() {
    if (formBoxKey.currentContext != null && mounted) {
      final RenderBox box =
          formBoxKey.currentContext!.findRenderObject() as RenderBox;
      if (box.hasSize) {
        setState(() {
          formHeight = box.size.height;
          isFormMeasured = true;
          isFormReady = true;
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          updateFormHeight();
        });
      }
    }
  }

  Future<void> _loadCurrentProfile() async {
    setState(() {
      isLoadingProfile = true;
      isFormReady = false;
    });

    try {
      currentProfile = await controller.getCurrentProfile();

      if (currentProfile != null) {
        nicknameController.text = currentProfile!.nickname;
        selectedSex = currentProfile!.sex;
        selectedBirthDate = currentProfile!.birthDate;
        selectedEducationLevel = currentProfile!.educationLevel;
        final currentLocale =
            Get.locale?.toString() ?? AppTranslations.SPANISH.countryCode;
        birthDateController.text =
            DateFormat.yMd(currentLocale).format(currentProfile!.birthDate);
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoadingProfile = false;
        });
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            updateFormHeight();
          }
        });
      });
    }
  }

  @override
  String getScreenTitle() {
    return 'User Profile';
  }

  void _confirmDeleteUser() {
    if (currentProfile == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
            title: 'Confirm Delete',
            mode: DialogMode.confirmCancel,
            primaryButtonText: 'Delete',
            onPrimaryPressed: () {
              Get.back();
              _deleteUser();
            },
            content:
                'Are you sure you want to delete this user profile? This action cannot be undone.',
            cancelButtonText: 'Cancel',
            onCancelPressed: () {
              Get.back();
            });
      },
    );
  }

  Future<void> _deleteUser() async {
    if (currentProfile == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      await controller.deleteProfile(currentProfile!.userId);
      Get.back();
      if (mounted) {
        AppSnackbar.showCustomSnackbar(
          context,
          'User profile deleted successfully',
        );
      }
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showCustomSnackbar(
        context,
        'Error deleting user profile',
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
  Widget build(BuildContext context) {
    if (isLoadingProfile) {
      return Scaffold(
        appBar: CustomAppBar(title: getScreenTitle()),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (currentProfile == null) {
      return Scaffold(
        appBar: CustomAppBar(title: getScreenTitle()),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No user profile found',
                style: TextStyleBase.bodyM,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      );
    }

    return super.build(context);
  }

  @override
  Widget buildActionButtons(BuildContext context) {
    if (!isFormReady) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading)
          Center(child: CircularProgressIndicator())
        else ...[
          Center(
            child: CustomPrimaryButton(
              text: 'Delete Profile',
              onPressed: _confirmDeleteUser,
              backgroundColor: AppColors.mainRed,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: CustomSecondaryButton(
              text: 'Back',
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ],
    );
  }
}
