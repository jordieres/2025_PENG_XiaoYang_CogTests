import 'package:msdtmt/app/utils/services/user_data_base_migration.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../constans/database_constants.dart';

class UserDatabaseHelper {
  static final UserDatabaseHelper _instance = UserDatabaseHelper._internal();
  static Database? _database;

  factory UserDatabaseHelper() {
    return _instance;
  }

  UserDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, DatabaseConstants.databaseName);

    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: _createDatabase,
      onUpgrade: _onUpgradeDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.userProfilesTable}(
        ${DatabaseConstants.userIdColumn} TEXT PRIMARY KEY,
        ${DatabaseConstants.nicknameColumn} TEXT NOT NULL,
        ${DatabaseConstants.sexColumn} TEXT NOT NULL,
        ${DatabaseConstants.birthDateColumn} TEXT NOT NULL,
        ${DatabaseConstants.educationLevelColumn} TEXT NOT NULL
      )
    ''');

    await db.execute('''
    CREATE TABLE ${DatabaseConstants.userTestResultsTable}(
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
  }

  Future<void> close() async {
    final db = await database;
    db.close();
    _database = null;
  }

  Future<void> deleteDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, DatabaseConstants.databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }

  Future<void> _onUpgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < DatabaseConstants.databaseVersion) {
      await UserDatabaseMigration.migrateV1ToV2(db);
    }
  }
}
