import '../../data/datasources/user_profle_data_soruce.dart';
import '../../data/model/user_profile_model.dart';
import '../entities/user_profile.dart';



abstract class UserProfileRepository {
  Future<List<UserProfile>> getAllProfiles();
  Future<UserProfile?> getProfileByUserId(String userId);
  Future<UserProfile?> getProfileByNickname(String nickname);
  Future<void> saveProfile(UserProfile profile);
  Future<void> deleteProfile(String userId);
  Future<List<String>> getAllNicknames();
  Future<List<String>> getAllUserId();
  Future<UserProfile?> getCurrentProfile();
  Future<void> setCurrentProfile(String userId);
}

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDataSource profileDataSource;

  UserProfileRepositoryImpl({
    required this.profileDataSource,
  });

  @override
  Future<List<UserProfile>> getAllProfiles() async {
    return await profileDataSource.getAllProfiles();
  }

  @override
  Future<UserProfile?> getProfileByUserId(String userId) async {
    return await profileDataSource.getProfileByUserId(userId);
  }

  @override
  Future<UserProfile?> getProfileByNickname(String nickname) async {
    return await profileDataSource.getProfileByNickname(nickname);
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    await profileDataSource.saveProfile(UserProfileModel.fromEntity(profile));
  }

  @override
  Future<void> deleteProfile(String userId) async {
    await profileDataSource.deleteProfile(userId);
  }

  @override
  Future<List<String>> getAllNicknames() async {
    return await profileDataSource.getAllNicknames();
  }

  @override
  Future<List<String>> getAllUserId() async {
    return await profileDataSource.getAllUserId();
  }

  @override
  Future<UserProfile?> getCurrentProfile() async {
    return await profileDataSource.getCurrentProfile();
  }

  @override
  Future<void> setCurrentProfile(String userId) async {
    await profileDataSource.setCurrentProfile(userId);
  }
}