import 'package:get/get.dart';
import '../../../../utils/services/local_storage_services.dart';
import '../../domain/entities/user_test_local_data_result.dart';
import '../../domain/repository/test_result_local_data_repository.dart';

class TestResultLocalDataController extends GetxController {
  final TestResultLocalDataRepository repository;

  TestResultLocalDataController({required this.repository});

  final RxList<UserTestLocalDataResult> testResults =
      <UserTestLocalDataResult>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> loadCurrentUserTestResults() async {
    isLoading.value = true;
    try {
      final currentUserId = await LocalStorageServices.getCurrentProfileId();
      if (currentUserId != null && currentUserId.isNotEmpty) {
        final results = await repository.getTestResultsByUserId(currentUserId);
        testResults.value = results;
      } else {
        testResults.value = [];
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadTestResultsByNickname(String nickname) async {
    isLoading.value = true;
    try {
      final results = await repository.getTestResultsByNickname(nickname);
      testResults.value = results;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> isReferenceCodeUsed(String referenceCode) async {
    return await repository.isReferenceCodeUsed(referenceCode);
  }

  Future<void> saveTestResult(UserTestLocalDataResult result) async {
    isLoading.value = true;
    try {
      await repository.saveTestResult(result);
    } finally {
      isLoading.value = false;
    }
  }
}
