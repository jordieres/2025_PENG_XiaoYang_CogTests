import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/ui/ui_utils.dart';
import '../../../user/domain/entities/user_profile.dart';
import '../../../user/domain/repository/user_profile_repository.dart';
import '../../../../config/themes/AppColors.dart';

class SelectUserController extends GetxController {
  final UserProfileRepository _userProfileRepository =
      Get.find<UserProfileRepository>();
  final RxList<String> userIds = <String>[].obs;
  final Rx<UserProfile?> currentProfile = Rx<UserProfile?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserIds();
    loadCurrentProfile();
  }

  Future<void> loadUserIds() async {
    isLoading.value = true;
    try {
      final ids = await _userProfileRepository.getAllUserId();
      userIds.value = ids;
    } catch (e) {
      showErrorMessage('Error al cargar IDs de usuarios: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCurrentProfile() async {
    isLoading.value = true;
    try {
      final profile = await _userProfileRepository.getCurrentProfile();
      currentProfile.value = profile;
    } catch (e) {
      showErrorMessage('Error al cargar perfil actual: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setCurrentProfile(String userId) async {
    isLoading.value = true;
    try {
      await _userProfileRepository.setCurrentProfile(userId);
      await loadCurrentProfile();
      if (currentProfile.value != null) {
        showSuccessMessage(
            'Perfil seleccionado: ${currentProfile.value!.nickname}');
      }
    } catch (e) {
      showErrorMessage('Error al establecer perfil: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<UserProfile?> getProfileByUserId(String userId) async {
    try {
      return await _userProfileRepository.getProfileByUserId(userId);
    } catch (e) {
      showErrorMessage('Error al obtener perfil por ID: $e');
      return null;
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
        backgroundColor: Colors.green.withAlpha(240),
      );
    }
  }
}
