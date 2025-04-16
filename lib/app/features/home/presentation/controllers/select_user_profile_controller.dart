import 'package:get/get.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../utils/ui/ui_utils.dart';
import '../../../user/domain/entities/user_profile.dart';
import '../../../user/domain/repository/user_profile_repository.dart';
import '../../../user/presentation/contoller/user_profile_controller.dart';
import '../../../../config/themes/AppColors.dart';

class SelectUserController extends UserProfileController {
  final RxList<String> userIds = <String>[].obs;
  final RxBool _needsRefresh = false.obs;

  Rx<UserProfile?> get currentProfile => selectedProfile;

  SelectUserController() : super(repository: Get.find<UserProfileRepository>());

  @override
  void onInit() {
    super.onInit();
    _updateUserIds();

    ever(_needsRefresh, (_) {
      if (_needsRefresh.value) {
        _refreshData();
        _needsRefresh.value = false;
      }
    });

    ever(profiles, (_) {
      _updateUserIds();
    });
  }

  void refreshAfterUserRegistration() {
    _needsRefresh.value = true;
  }

  Future<void> _refreshData() async {
    await loadProfiles();
    await loadCurrentProfile();
  }

  @override
  Future<void> loadProfiles() async {
    await super.loadProfiles();
    _updateUserIds();
  }

  void _updateUserIds() {
    userIds.value = profiles.map((profile) => profile.userId).toList();
  }

  UserProfile? getProfileByUserId(String userId) {
    return profiles.firstWhereOrNull((profile) => profile.userId == userId);
  }

  Future<void> setCurrentProfile(String userId) async {
    isLoading.value = true;
    try {
      await repository.setCurrentProfile(userId);
      await loadCurrentProfile();
      if (selectedProfile.value != null) {
        showSuccessMessage(
            '${SelectUserProfileDialogText.profileSelectedSuccess.tr}: ${selectedProfile.value!.nickname}');
      }
    } catch (e) {
      showErrorMessage(
          '${SelectUserProfileDialogText.profileSelectedError.tr}: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> deleteProfile(String userId) async {
    isLoading.value = true;
    try {
      final profile = getProfileByUserId(userId);
      await repository.deleteProfileAndResultsHistory(userId);
      profiles.removeWhere((profile) => profile.userId == userId);
      userIds.remove(userId);

      if (selectedProfile.value?.userId == userId) {
        selectedProfile.value = null;
        if (userIds.isNotEmpty) {
          await setCurrentProfile(userIds[0]);
        }
      }

      if (profile != null) {
        showSuccessMessage(
            '${SelectUserProfileDialogText.profileDeletedSuccess.tr}: ${profile.nickname}');
      } else {
        showSuccessMessage(
            SelectUserProfileDialogText.profileDeletedSuccess.tr);
      }
    } catch (e) {
      showErrorMessage(
          '${SelectUserProfileDialogText.profileDeletedError.tr}: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void showErrorMessage(String message) {
    if (Get.context != null) {
      AppSnackbar.showCustomSnackbar(
        Get.context!,
        message,
        backgroundColor: AppColors.mainRed.withAlpha(240),
      );
    }
  }

  void showSuccessMessage(String message) {
    if (Get.context != null) {
      AppSnackbar.showCustomSnackbar(
        Get.context!,
        message,
        backgroundColor: AppColors.testTMTCorrectCircleStroke.withAlpha(230),
      );
    }
  }
}
