Data Layer
==========

Overview
--------

The Data Layer in the User module is responsible for implementing the repository interfaces defined in the domain layer. It handles the actual data operations, whether retrieving from local storage, communicating with APIs, or processing in-memory data.

Models
------

UserProfileModel
^^^^^^^^^^^^^^^^

User profile model (``lib/app/features/user/data/model/user_profile_model.dart``):

- Extends UserProfile entity with serialization capabilities
- Implements toMap() for database storage:
  * Converts enum values to strings for storage
  * Formats DateTime to ISO 8601 string
  * Maps all fields to a database-friendly structure

- Provides fromMap() factory for database retrieval:
  * Parses stored strings back to enum values
  * Converts ISO 8601 strings to DateTime objects
  * Creates new UserProfileModel with parsed data

- Includes fromEntity() factory to convert domain entity to data model

UserTestResultLocalDataModel
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Test result model (``lib/app/features/user/data/model/user_test_result_local_data_model.dart``):

- Extends UserTestLocalDataResult with database serialization
- Implements toMap() for creating database records:
  * Converts date to ISO 8601 string
  * Maps all fields to database columns

- Provides fromMap() factory for database record conversion:
  * Parses date strings to DateTime
  * Maps database column names to model properties

- Includes fromEntity() factory to convert domain entity to data model

Data Sources
------------

UserProfileDataSource
^^^^^^^^^^^^^^^^^^^^^

Profile data source interface (``lib/app/features/user/data/datasources/user_profle_data_soruce.dart``):

- Defines methods for user data operations:
  * ``getAllProfiles()``: Retrieves all user profiles
  * ``getProfileByNickname()``: Finds profile by nickname
  * ``saveProfile()``: Saves new or updated profile
  * ``deleteProfileAndResultHistory()``: Removes user data
  * ``getAllNicknames()``: Gets list of existing nicknames
  * ``getAllUserId()``: Gets list of user IDs
  * ``setCurrentProfile()``: Sets active user profile
  * ``clearCurrentProfile()``: Clears active profile
  * ``getCurrentProfile()``: Gets current active profile

UserProfileDataSourceImpl
^^^^^^^^^^^^^^^^^^^^^^^^^

Implementation (``lib/app/features/user/data/datasources/user_profle_data_soruce.dart``):

- Implements UserProfileDataSource interface using SQLite:
  * Uses UserDatabaseHelper for database operations
  * Creates and executes SQL queries for CRUD operations
  * Converts between database rows and data models
  * Uses LocalStorageServices for current user preferences

TestResultLocalDataSource
^^^^^^^^^^^^^^^^^^^^^^^^^

Test result data source interface (``lib/app/features/user/data/datasources/test_result_data_soruce.dart``):

- Defines methods for test result operations:
  * ``getTestResultsByUserId()``: Gets results for specific user
  * ``getTestResultsByNickname()``: Gets results by user nickname
  * ``saveTestResult()``: Stores new test result
  * ``isReferenceCodeUsed()``: Checks for reference code duplicates

TestResultDataSourceImpl
^^^^^^^^^^^^^^^^^^^^^^^^

Implementation (``lib/app/features/user/data/datasources/test_result_data_soruce.dart``):

- Implements TestResultLocalDataSource interface:
  * Uses SQLite database for result storage
  * Creates SQL queries for test result operations
  * Converts between database records and model objects
  * Integrates with UserDatabaseHelper for database access

Repository Implementations
--------------------------

UserProfileRepositoryImpl
^^^^^^^^^^^^^^^^^^^^^^^^^

Implementation (``lib/app/features/user/domain/repository/user_profile_repository.dart``):

- Implements UserProfileRepository interface:
  * Delegates database operations to data source
  * Converts between models and domain entities
  * Manages profile creation and updates
  * Handles current profile selection logic
  * Coordinates profile and test result deletion

TestResultLocalDataRepositoryImpl
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Implementation (``lib/app/features/user/domain/repository/test_result_local_data_repository.dart``):

- Implements TestResultLocalDataRepository interface:
  * Delegates database operations to data source
  * Converts between models and domain entities
  * Manages test result storage and retrieval
  * Performs reference code validation