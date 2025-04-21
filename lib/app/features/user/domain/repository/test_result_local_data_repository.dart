import '../../data/datasources/test_result_data_soruce.dart';
import '../../data/model/user_test_result_local_data_model.dart';
import '../entities/user_test_local_data_result.dart';

abstract class TestResultLocalDataRepository {
  Future<List<UserTestLocalDataResult>> getTestResultsByUserId(String userId);

  Future<List<UserTestLocalDataResult>> getTestResultsByNickname(String nickname);

  Future<void> saveTestResult(UserTestLocalDataResult result);

  Future<bool> isReferenceCodeUsed(String referenceCode);
}

class TestResultLocalDataRepositoryImpl implements TestResultLocalDataRepository {
  final TestResultLocalDataSource testResultDataSource;

  TestResultLocalDataRepositoryImpl({
    required this.testResultDataSource,
  });

  @override
  Future<List<UserTestLocalDataResult>> getTestResultsByUserId(String userId) async {
    return await testResultDataSource.getTestResultsByUserId(userId);
  }

  @override
  Future<List<UserTestLocalDataResult>> getTestResultsByNickname(String nickname) async {
    return await testResultDataSource.getTestResultsByNickname(nickname);
  }

  @override
  Future<void> saveTestResult(UserTestLocalDataResult result) async {
    await testResultDataSource
        .saveTestResult(UserTestResultLocalDataModel.fromEntity(result));
  }

  @override
  Future<bool> isReferenceCodeUsed(String referenceCode) async {
    return await testResultDataSource.isReferenceCodeUsed(referenceCode);
  }
}
