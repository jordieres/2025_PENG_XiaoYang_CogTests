import '../../data/datasources/test_result_data_soruce.dart';
import '../../data/model/user_test_result_model.dart';
import '../entities/user_test_result.dart';

abstract class TestResultRepository {
  Future<List<UserTestResult>> getTestResultsByUserId(String userId);

  Future<List<UserTestResult>> getTestResultsByNickname(String nickname);

  Future<void> saveTestResult(UserTestResult result);

  Future<bool> isReferenceCodeUsed(String referenceCode);
}

class TestResultRepositoryImpl implements TestResultRepository {
  final TestResultDataSource testResultDataSource;

  TestResultRepositoryImpl({
    required this.testResultDataSource,
  });

  @override
  Future<List<UserTestResult>> getTestResultsByUserId(String userId) async {
    return await testResultDataSource.getTestResultsByUserId(userId);
  }

  @override
  Future<List<UserTestResult>> getTestResultsByNickname(String nickname) async {
    return await testResultDataSource.getTestResultsByNickname(nickname);
  }

  @override
  Future<void> saveTestResult(UserTestResult result) async {
    await testResultDataSource
        .saveTestResult(UserTestResultModel.fromEntity(result));
  }

  @override
  Future<bool> isReferenceCodeUsed(String referenceCode) async {
    return await testResultDataSource.isReferenceCodeUsed(referenceCode);
  }
}
