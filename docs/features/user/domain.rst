Domain Layer
============

Overview
--------

The Domain Layer of the User module contains the business logic and rules that are independent of UI implementation and data sources. It defines entities, repository interfaces, and use cases that encapsulate the core functionality of the user feature.

Entities
--------

UserProfile
^^^^^^^^^^^

User profile entity (``lib/app/features/user/domain/entities/user_profile.dart``):

- Core entity with the following properties:
  * ``userId``: String identifier (generated with UUID)
  * ``nickname``: Display name
  * ``sex``: Enum with values male("M") and female("F")
  * ``birthDate``: DateTime for birth date
  * ``educationLevel``: Enum with values primary("1"), secondary("2"), graduate("G"), master("M"), doctorate("D")

- Provides two constructors:
  * Basic constructor with required fields (nickname, sex, birthDate, educationLevel)
  * withUserId constructor for existing users

UserTestLocalDataResult
^^^^^^^^^^^^^^^^^^^^^^^

Test result entity (``lib/app/features/user/domain/entities/user_test_local_data_result.dart``):

- Simple data class with the following properties:
  * ``referenceCode``: String identifier for the test session
  * ``date``: DateTime when test was completed
  * ``tmtATime``: double representing completion time for TMT-A test
  * ``tmtBTime``: double representing completion time for TMT-B test

Repository Interfaces
---------------------

UserProfileRepository
^^^^^^^^^^^^^^^^^^^^^

User repository interface (``lib/app/features/user/domain/repository/user_profile_repository.dart``):

- Defines contract for user data operations:
  * ``getAllProfiles()``: Returns List<UserProfile>
  * ``getProfileByNickname(String nickname)``: Returns UserProfile?
  * ``saveProfile(UserProfile profile)``: Void future method
  * ``deleteProfileAndResultsHistory(String userId)``: Void future method
  * ``getAllUserId()``: Returns List<String>
  * ``getCurrentProfile()``: Returns UserProfile?
  * ``setCurrentProfile(String userId)``: Void future method

TestResultLocalDataRepository
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Test result repository interface (``lib/app/features/user/domain/repository/test_result_local_data_repository.dart``):

- Defines contract for test result operations:
  * ``getTestResultsByUserId(String userId)``: Returns List<UserTestLocalDataResult>
  * ``getTestResultsByNickname(String nickname)``: Returns List<UserTestLocalDataResult>
  * ``saveTestResult(UserTestLocalDataResult result)``: Void future method
  * ``isReferenceCodeUsed(String referenceCode)``: Returns bool future