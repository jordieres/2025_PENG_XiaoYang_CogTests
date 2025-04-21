import '../../data/datasources/user_profle_data_soruce.dart';
import '../../data/model/user_profile_model.dart';
import '../entities/user_profile.dart';

abstract class UserProfileRepository {
  Future<List<UserProfile>> getAllProfiles();

  Future<UserProfile?> getProfileByNickname(String nickname);

  Future<void> saveProfile(UserProfile profile);

  Future<void> deleteProfileAndResultsHistory(String userId);

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
  Future<UserProfile?> getProfileByNickname(String nickname) async {
    return await profileDataSource.getProfileByNickname(nickname);
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    await profileDataSource.saveProfile(UserProfileModel.fromEntity(profile));
    final currentProfile = await getCurrentProfile();
    if (currentProfile == null || currentProfile.userId.isEmpty) {
      await setCurrentProfile(profile.userId);
    }
  }

  @override
  Future<void> deleteProfileAndResultsHistory(String userId) async {
    await profileDataSource.deleteProfileAndResultHistory(userId);
    final allCurrentIds = await getAllUserId();
    if (allCurrentIds.isEmpty) {
      await profileDataSource.clearCurrentProfile(userId);
    } else {
      await setCurrentProfile(allCurrentIds.first);
    }
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
