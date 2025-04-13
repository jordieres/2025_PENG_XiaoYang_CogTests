import 'package:get/get.dart';
import '../../domain/entities/user_test_result.dart';
import '../../domain/repository/test_result_repository.dart';

class TestResultController extends GetxController {
  final TestResultRepository repository;

  TestResultController({required this.repository});

  final RxList<UserTestResult> testResults = <UserTestResult>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> loadTestResultsByUserId(String userId) async {
    isLoading.value = true;
    try {
      final results = await repository.getTestResultsByUserId(userId);
      testResults.value = results;
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

  Future<void> saveTestResult(UserTestResult result) async {
    isLoading.value = true;
    try {
      await repository.saveTestResult(result);
    } finally {
      isLoading.value = false;
    }
  }
}
