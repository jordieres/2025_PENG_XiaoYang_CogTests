Presentation Layer
==================

Overview
--------

The Presentation Layer of the User module implements the user interface components and interaction logic. It follows the GetX state management pattern to maintain a reactive UI while keeping the code clean and modular.

Screens
-------

RegisterUserScreen
^^^^^^^^^^^^^^^^^^

User registration screen (``lib/app/features/user/presentation/screen/register_user_screen.dart``):

- Implements form for new user registration with field validation
- Collects nickname, sex, birth date, and education level
- Prevents duplicate nicknames through real-time validation
- Provides date picker for birth date selection
- Uses responsive layout for different device sizes

CurrentUserDataScreen
^^^^^^^^^^^^^^^^^^^^^

Current user screen (``lib/app/features/user/presentation/screen/current_user_data_screen.dart``):

- Displays selected user profile information in read-only mode
- Extends RegisterUserScreenBase for consistent layout
- Provides profile deletion functionality with confirmation dialog
- Handles navigation back to home after profile deletion
- Shows error message if no profile is selected

UserResultHistoryScreen
^^^^^^^^^^^^^^^^^^^^^^^

Result history screen (``lib/app/features/user/presentation/screen/user_result_history_screen.dart``):

- Displays table of TMT test results for current user
- Shows date, reference code, TMT-A time, and TMT-B time
- Implements responsive layout with scrollable content
- Uses localized date formatting for different regions
- Handles empty state with appropriate message

UserScreenBase
^^^^^^^^^^^^^^

Base screen (``lib/app/features/user/presentation/screen/user_screen_base.dart``):

- Provides shared layout and functionality for user screens
- Implements common form fields (nickname, sex, birth date, education)
- Creates consistent form validation rules
- Handles field spacing and responsive layout calculations
- Manages form state and focus navigation

Controllers
-----------

UserProfileController
^^^^^^^^^^^^^^^^^^^^^

Profile controller (``lib/app/features/user/presentation/contoller/user_profile_controller.dart``):

- Manages user profile data retrieval and persistence
- Provides reactive state for UI components
- Handles profile loading, saving and deletion
- Coordinates with repository layer for data operations
- Manages current active profile selection

TestResultLocalDataController
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Test result controller (``lib/app/features/user/presentation/contoller/test_result_controller.dart``):

- Manages loading and display of user test results
- Provides reactive state for test history UI
- Handles result loading by user ID and nickname
- Validates reference codes for duplicate detection
- Saves new test results to local storage

Bindings
--------

UserProfileBinding
^^^^^^^^^^^^^^^^^^

User binding (``lib/app/features/user/presentation/binding/user_profile_binding.dart``):

- Registers dependencies for user profile management
- Creates and configures UserDatabaseHelper
- Sets up UserProfileDataSource with database helper
- Configures UserProfileRepository with data source
- Registers UserProfileController for UI state management

UserHistoryBinding
^^^^^^^^^^^^^^^^^^

History binding (``lib/app/features/user/presentation/binding/user_history_binding.dart``):

- Registers dependencies for test result history
- Initializes database and data source components
- Sets up TestResultLocalDataRepository
- Registers TestResultLocalDataController
- Ensures dependencies are only registered once

TestResultLocalDataBinding
^^^^^^^^^^^^^^^^^^^^^^^^^^

Result binding (``lib/app/features/user/presentation/binding/test_result_local_data_binding.dart``):

- Configures database helper for test results
- Sets up TestResultLocalDataSource with database helper
- Configures TestResultLocalDataRepository with data source
- Registers TestResultLocalDataController
- Manages dependency lifecycle for test result operations