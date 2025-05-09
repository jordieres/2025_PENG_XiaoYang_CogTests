class DatabaseConstants {
  static const String databaseName = 'user_database.db';
  static const int databaseVersion = 2;

  static const String userProfilesTable = 'user_profiles';
  static const String userTestResultsTable = 'user_test_results';

  ///User profile columns
  static const String userIdColumn = 'userId';
  static const String nicknameColumn = 'nickname';
  static const String sexColumn = 'sex';
  static const String birthDateColumn = 'birthDate';
  static const String educationLevelColumn = 'educationLevel';

  ///User result tablet columns
  static const String resultIdColumn = 'resultId';
  static const String referenceCodeColumn = 'referenceCode';
  static const String dateColumn = 'date';
  static const String tmtATimeColumn = 'tmtATime';
  static const String tmtBTimeColumn = 'tmtBTime';
  static const String handUsedColumn = 'handUsed';
}
