import 'package:sqflite/sqflite.dart';

import '../../../../constans/database_constants.dart';
import '../../../../utils/services/user_data_base_helper.dart';
import '../../../../utils/services/local_storage_services.dart';
import '../model/user_test_result_model.dart';

abstract class TestResultDataSource {
  Future<List<UserTestResultModel>> getTestResultsByUserId(String userId);
  Future<List<UserTestResultModel>> getTestResultsByNickname(String nickname);
  Future<void> saveTestResult(UserTestResultModel result);
  Future<bool> isReferenceCodeUsed(String referenceCode);
}

class TestResultDataSourceImpl implements TestResultDataSource {
  final UserDatabaseHelper databaseHelper;

  TestResultDataSourceImpl({required this.databaseHelper});


  @override
  Future<List<UserTestResultModel>> getTestResultsByUserId(String userId) async {
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
  Future<List<UserTestResultModel>> getTestResultsByNickname(String nickname) async {
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
}