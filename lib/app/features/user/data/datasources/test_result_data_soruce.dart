import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../../constans/database_constants.dart';
import '../../../../utils/services/user_data_base_helper.dart';
import '../../../../utils/services/local_storage_services.dart';
import '../../../home/domain/entities/reference_validation_result_entity.dart';
import '../model/user_test_result_local_data_model.dart';

abstract class TestResultLocalDataSource {
  Future<List<UserTestResultLocalDataModel>> getTestResultsByUserId(
      String userId);

  Future<List<UserTestResultLocalDataModel>> getTestResultsByNickname(
      String nickname);

  Future<void> saveTestResult(UserTestResultLocalDataModel result);

  Future<bool> isReferenceCodeUsed(String referenceCode);
}

class TestResultDataSourceImpl implements TestResultLocalDataSource {
  final UserDatabaseHelper databaseHelper;

  TestResultDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<UserTestResultLocalDataModel>> getTestResultsByUserId(
      String userId) async {
    final db = await databaseHelper.database;
    final resultsData = await db.query(
      DatabaseConstants.userTestResultsTable,
      where: '${DatabaseConstants.userIdColumn} = ?',
      whereArgs: [userId],
      orderBy: '${DatabaseConstants.dateColumn} DESC',
    );

    return resultsData
        .map((resultData) => UserTestResultLocalDataModel.fromMap(resultData))
        .toList();
  }

  @override
  Future<List<UserTestResultLocalDataModel>> getTestResultsByNickname(
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
  Future<void> saveTestResult(UserTestResultLocalDataModel result) async {
    final db = await databaseHelper.database;

    final currentProfileId = await LocalStorageServices.getCurrentProfileId();
    if (currentProfileId == null || currentProfileId.isEmpty) {
      throw Exception('No user profile selected');
    }

    final resultMap = result.toMap();
    resultMap[DatabaseConstants.resultIdColumn] = const Uuid().v4();
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

    return count != null &&
        count >= ReferenceValidationResult.MAX_NUMBER_EXISTS;
  }
}
