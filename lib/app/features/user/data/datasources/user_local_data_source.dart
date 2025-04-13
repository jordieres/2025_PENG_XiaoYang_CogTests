import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../../constans/database_constants.dart';
import '../../../../utils/services/user_data_base_helper.dart';
import '../../../../utils/services/local_storage_services.dart';
import '../model/user_profile_model.dart';
import '../model/user_test_result_model.dart';

abstract class UserLocalDataSource {
  Future<List<UserProfileModel>> getAllProfiles();

  Future<UserProfileModel?> getProfileByUserId(String userId);

  Future<UserProfileModel?> getProfileByNickname(String nickname);

  Future<void> saveProfile(UserProfileModel profile);

  Future<void> deleteProfile(String userId);

  Future<List<UserTestResultModel>> getTestResults();

  Future<List<UserTestResultModel>> getTestResultsByUserId(String userId);

  Future<List<UserTestResultModel>> getTestResultsByNickname(String nickname);

  Future<void> saveTestResult(UserTestResultModel result);

  Future<bool> isReferenceCodeUsed(String referenceCode);

  Future<List<String>> getAllNicknames();

  Future<List<String>> getAllUserId();

  Future<void> setCurrentProfile(String userId);

  Future<UserProfileModel?> getCurrentProfile();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final UserDatabaseHelper databaseHelper;

  UserLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<UserProfileModel>> getAllProfiles() async {
    final db = await databaseHelper.database;
    final profilesData = await db.query(DatabaseConstants.userProfilesTable);

    return profilesData
        .map((profileData) => UserProfileModel.fromMap(profileData))
        .toList();
  }

  @override
  Future<UserProfileModel?> getProfileByUserId(String userId) async {
    final db = await databaseHelper.database;
    final profilesData = await db.query(
      DatabaseConstants.userProfilesTable,
      where: '${DatabaseConstants.userIdColumn} = ?',
      whereArgs: [userId],
    );

    if (profilesData.isEmpty) {
      return null;
    }

    return UserProfileModel.fromMap(profilesData.first);
  }

  @override
  Future<UserProfileModel?> getProfileByNickname(String nickname) async {
    final db = await databaseHelper.database;
    final profilesData = await db.query(
      DatabaseConstants.userProfilesTable,
      where: '${DatabaseConstants.nicknameColumn} = ?',
      whereArgs: [nickname],
    );

    if (profilesData.isEmpty) {
      return null;
    }

    return UserProfileModel.fromMap(profilesData.first);
  }

  @override
  Future<void> saveProfile(UserProfileModel profile) async {
    final db = await databaseHelper.database;
    profile.userId = const Uuid().v4();
    await db.insert(
      DatabaseConstants.userProfilesTable,
      profile.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    final currentProfileId = await LocalStorageServices.getCurrentProfileId();
    if (currentProfileId == null || currentProfileId.isEmpty) {
      await setCurrentProfile(profile.userId);
    }
  }

  @override
  Future<void> deleteProfile(String userId) async {
    final db = await databaseHelper.database;

    await db.delete(
      DatabaseConstants.userProfilesTable,
      where: '${DatabaseConstants.userIdColumn} = ?',
      whereArgs: [userId],
    );
  }

  @override
  Future<List<UserTestResultModel>> getTestResults() async {
    final db = await databaseHelper.database;
    final resultsData = await db.query(
      DatabaseConstants.userTestResultsTable,
      orderBy: '${DatabaseConstants.dateColumn} DESC',
    );

    return resultsData
        .map((resultData) => UserTestResultModel.fromMap(resultData))
        .toList();
  }

  @override
  Future<List<UserTestResultModel>> getTestResultsByUserId(
      String userId) async {
    final db = await databaseHelper.database;
    final resultsData = await db.query(
      DatabaseConstants.userTestResultsTable,
      where: '${DatabaseConstants.userIdColumn} = ?',
      whereArgs: [userId],
      orderBy: '${DatabaseConstants.dateColumn} DESC',
    );

    return resultsData
        .map((resultData) => UserTestResultModel.fromMap(resultData))
        .toList();
  }

  @override
  Future<List<UserTestResultModel>> getTestResultsByNickname(
      String nickname) async {
    final db = await databaseHelper.database;

    final profilesData = await db.query(
      DatabaseConstants.userProfilesTable,
      columns: [DatabaseConstants.userIdColumn],
      where: '${DatabaseConstants.nicknameColumn} = ?',
      whereArgs: [nickname],
    );

    if (profilesData.isEmpty) {
      return [];
    }

    final userId = profilesData.first[DatabaseConstants.userIdColumn] as String;

    return getTestResultsByUserId(userId);
  }

  @override
  Future<void> saveTestResult(UserTestResultModel result) async {
    final db = await databaseHelper.database;

    final currentProfileId = await LocalStorageServices.getCurrentProfileId();
    if (currentProfileId == null || currentProfileId.isEmpty) {
      throw Exception('No user profile selected');
    }

    final resultMap = result.toMap();
    resultMap[DatabaseConstants.userIdColumn] = currentProfileId;
    await db.insert(
      DatabaseConstants.userTestResultsTable,
      resultMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<bool> isReferenceCodeUsed(String referenceCode) async {
    final db = await databaseHelper.database;
    final currentProfileId = await LocalStorageServices.getCurrentProfileId();
    if (currentProfileId == null || currentProfileId.isEmpty) {
      return false;
    }
    final count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM ${DatabaseConstants.userTestResultsTable} WHERE ${DatabaseConstants.referenceCodeColumn} = ? AND ${DatabaseConstants.userIdColumn} = ?',
      [referenceCode, currentProfileId],
    ));

    return count != null && count > 0;
  }

  @override
  Future<List<String>> getAllNicknames() async {
    final db = await databaseHelper.database;
    final results = await db.query(
      DatabaseConstants.userProfilesTable,
      columns: [DatabaseConstants.nicknameColumn],
    );

    return results
        .map((result) => result[DatabaseConstants.nicknameColumn] as String)
        .toList();
  }

  @override
  Future<List<String>> getAllUserId() async {
    final db = await databaseHelper.database;
    final results = await db.query(
      DatabaseConstants.userProfilesTable,
      columns: [DatabaseConstants.userIdColumn],
    );

    return results
        .map((result) => result[DatabaseConstants.userIdColumn] as String)
        .toList();
  }

  @override
  Future<void> setCurrentProfile(String userId) async {
    await LocalStorageServices.setCurrentProfileId(userId);
  }

  @override
  Future<UserProfileModel?> getCurrentProfile() async {
    final currentProfileId = await LocalStorageServices.getCurrentProfileId();
    return await getProfileByUserId(currentProfileId ?? '');
  }
}
