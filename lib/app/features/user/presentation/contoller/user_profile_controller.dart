import 'package:get/get.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repository/user_profile_repository.dart';

class UserProfileController extends GetxController {
  final UserProfileRepository repository;

  UserProfileController({required this.repository});

  final RxList<UserProfile> profiles = <UserProfile>[].obs;
  final Rx<UserProfile?> selectedProfile = Rx<UserProfile?>(null);
  final RxString selectedUserId = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfiles();
    loadCurrentProfile();
  }

  Future<void> loadProfiles() async {
    isLoading.value = true;
    try {
      final allProfiles = await repository.getAllProfiles();
      profiles.value = allProfiles;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCurrentProfile() async {
    isLoading.value = true;
    try {
      final profile = await repository.getCurrentProfile();
      if (profile != null) {
        selectedProfile.value = profile;
        selectedUserId.value = profile.userId;
      } else if (profiles.isNotEmpty) {
        selectedProfile.value = profiles.first;
        selectedUserId.value = profiles.first.userId;
        await repository.setCurrentProfile(selectedUserId.value);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setSelectedUserId(String userId) async {
    selectedUserId.value = userId;
    final profile = await repository.getProfileByUserId(userId);
    selectedProfile.value = profile;
    await repository.setCurrentProfile(userId);
  }

  Future<void> saveProfile(UserProfile profile) async {
    isLoading.value = true;
    try {
      await repository.saveProfile(profile);
      await loadProfiles();
      // If this is the first profile, select it
      if (selectedProfile.value == null && profiles.isNotEmpty) {
        await loadCurrentProfile();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProfile(String userId) async {
    isLoading.value = true;
    try {
      await repository.deleteProfile(userId);
      await loadProfiles();
      if (selectedUserId.value == userId) {
        if (profiles.isNotEmpty) {
          selectedUserId.value = profiles.first.userId;
          selectedProfile.value = profiles.first;
          await repository.setCurrentProfile(selectedUserId.value);
        } else {
          selectedUserId.value = '';
          selectedProfile.value = null;
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<UserProfile?> getProfileByUserId(String userId) async {
    return await repository.getProfileByUserId(userId);
  }

  Future<UserProfile?> getProfileByNickname(String nickname) async {
    return await repository.getProfileByNickname(nickname);
  }

  Future<UserProfile?> getCurrentProfile() async {
    return await repository.getCurrentProfile();
  }
}