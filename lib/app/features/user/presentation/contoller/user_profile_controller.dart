import 'package:get/get.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/user_test_result.dart';
import '../../domain/repository/user_repository.dart';

class UserProfileController extends GetxController {
  final UserRepository repository;

  UserProfileController({required this.repository});

  final RxList<UserProfile> profiles = <UserProfile>[].obs;
  final Rx<UserProfile?> selectedProfile = Rx<UserProfile?>(null);
  final RxString selectedUserId = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<UserTestResult> testResults = <UserTestResult>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProfiles();
    loadAllTestResults();
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

  Future<void> setSelectedUserId(String userId) async {
    selectedUserId.value = userId;
    final profile = await repository.getProfileByUserId(userId);
    selectedProfile.value = profile;
  }

  Future<void> loadAllTestResults() async {
    isLoading.value = true;
    try {
      final results = await repository.getTestResults();
      testResults.value = results;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveProfile(UserProfile profile) async {
    isLoading.value = true;
    try {
      await repository.saveProfile(profile);
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
        selectedUserId.value = profiles.isNotEmpty ? profiles.first.userId : '';
        selectedProfile.value = profiles.isNotEmpty ? profiles.first : null;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> isReferenceCodeUsed(String referenceCode) async {
    return await repository.isReferenceCodeUsed(referenceCode);
  }

  Future<void> saveTestResult(UserTestResult result) async {
    isLoading.value = true;
    try {
      await repository.saveTestResult(result);
      await loadAllTestResults();
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
