import '../../data/datasources/user_local_data_source.dart';
import '../../data/model/user_profile_model.dart';
import '../../data/model/user_test_result_model.dart';
import '../entities/user_profile.dart';
import '../entities/user_test_result.dart';

abstract class UserRepository {
  Future<List<UserProfile>> getAllProfiles();

  Future<UserProfile?> getProfileByUserId(String userId);

  Future<UserProfile?> getProfileByNickname(String nickname);

  Future<void> saveProfile(UserProfile profile);

  Future<void> deleteProfile(String userId);

  Future<List<UserTestResult>> getTestResults();

  Future<List<UserTestResult>> getTestResultsByUserId(String userId);

  Future<List<UserTestResult>> getTestResultsByNickname(String nickname);

  Future<void> saveTestResult(UserTestResult result);

  Future<bool> isReferenceCodeUsed(String referenceCode);

  Future<List<String>> getAllNicknames();

  Future<List<String>> getAllUserId();
}

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({required this.localDataSource});

  @override
  Future<List<UserProfile>> getAllProfiles() async {
    final modelList = await localDataSource.getAllProfiles();
    return modelList;
  }

  @override
  Future<UserProfile?> getProfileByUserId(String userId) async {
    return await localDataSource.getProfileByUserId(userId);
  }

  @override
  Future<UserProfile?> getProfileByNickname(String nickname) async {
    return await localDataSource.getProfileByNickname(nickname);
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    await localDataSource.saveProfile(UserProfileModel.fromEntity(profile));
  }

  @override
  Future<void> deleteProfile(String userId) async {
    await localDataSource.deleteProfile(userId);
  }

  @override
  Future<List<UserTestResult>> getTestResults() async {
    final modelList = await localDataSource.getTestResults();
    return modelList;
  }

  @override
  Future<List<UserTestResult>> getTestResultsByUserId(String userId) async {
    final modelList = await localDataSource.getTestResultsByUserId(userId);
    return modelList;
  }

  @override
  Future<List<UserTestResult>> getTestResultsByNickname(String nickname) async {
    final modelList = await localDataSource.getTestResultsByNickname(nickname);
    return modelList;
  }

  @override
  Future<void> saveTestResult(UserTestResult result) async {
    await localDataSource
        .saveTestResult(UserTestResultModel.fromEntity(result));
  }

  @override
  Future<bool> isReferenceCodeUsed(String referenceCode) async {
    return await localDataSource.isReferenceCodeUsed(referenceCode);
  }

  @override
  Future<List<String>> getAllNicknames() async {
    return await localDataSource.getAllNicknames();
  }

  @override
  Future<List<String>> getAllUserId() async {
    return await localDataSource.getAllUserId();
  }
}
