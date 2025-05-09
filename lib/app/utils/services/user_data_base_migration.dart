import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../constans/database_constants.dart';

class UserDatabaseMigration {
  /// Migrates the database from version 1 to version 2.
  /// Adds resultId as primary key and handUsed column to the user_test_results table.
  static Future<void> migrateV1ToV2(Database db) async {
    // 1. Create temporary table with new structure
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.userTestResultsTable}_temp(
        ${DatabaseConstants.resultIdColumn} TEXT PRIMARY KEY,
        ${DatabaseConstants.referenceCodeColumn} TEXT NOT NULL,
        ${DatabaseConstants.userIdColumn} TEXT NOT NULL,
        ${DatabaseConstants.dateColumn} TEXT NOT NULL,
        ${DatabaseConstants.tmtATimeColumn} REAL NOT NULL,
        ${DatabaseConstants.tmtBTimeColumn} REAL NOT NULL,
        ${DatabaseConstants.handUsedColumn} TEXT NOT NULL,
        FOREIGN KEY (${DatabaseConstants.userIdColumn}) REFERENCES ${DatabaseConstants.userProfilesTable}(${DatabaseConstants.userIdColumn})
      )
    ''');

    // 2. Copy existing data and generate UUIDs and default value for handUsed
    final uuid = Uuid();
    final existingData = await db.query(DatabaseConstants.userTestResultsTable);

    for (var row in existingData) {
      final newId = uuid.v4();
      final newRow = Map<String, Object?>.from(row);
      newRow[DatabaseConstants.resultIdColumn] = newId;
      newRow[DatabaseConstants.handUsedColumn] = 'D'; // Default value

      await db.insert('${DatabaseConstants.userTestResultsTable}_temp', newRow);
    }

    // 3. Drop original table
    await db.execute('DROP TABLE ${DatabaseConstants.userTestResultsTable}');

    // 4. Rename temporary table to original name
    await db.execute(
        'ALTER TABLE ${DatabaseConstants.userTestResultsTable}_temp RENAME TO ${DatabaseConstants.userTestResultsTable}');
  }
}
