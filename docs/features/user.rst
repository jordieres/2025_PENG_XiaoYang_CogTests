User Module
===========

Overview
--------

The User module manages user profiles and test result history in the MS-dTMT application. It provides functionality for creating, viewing, and managing user profiles along with storing and displaying their test performance results.

Module Structure
----------------

The User module follows a clean architecture approach with three distinct layers:

.. toctree::
   :maxdepth: 1
   :caption: Architectural Layers:

   user/presentation
   user/domain
   user/data

Key Features
------------

- User profile creation and management
- Selection of active user from multiple profiles
- Storage of TMT test results by user
- Viewing test history with performance metrics
- Deletion of user profiles with associated test results

Core Components
---------------

Presentation Layer
^^^^^^^^^^^^^^^^^^

- **Screens**:
  - ``RegisterUserScreen``: Form for creating new user profiles
  - ``CurrentUserDataScreen``: View and manage existing user profile
  - ``UserResultHistoryScreen``: Display test results history
  - ``UserScreenBase``: Base class for shared screen functionality

- **Controllers**:
  - ``UserProfileController``: Manages user profile state and operations
  - ``TestResultLocalDataController``: Handles test result data operations

- **Bindings**:
  - ``UserProfileBinding``: Dependency injection for user profile components
  - ``UserHistoryBinding``: Dependency injection for history components

Domain Layer
^^^^^^^^^^^^

- **Entities**:
  - ``UserProfile``: Core domain entity with user identification and demographic information
  - ``UserTestLocalDataResult``: Domain entity for test result data

- **Repository Interfaces**:
  - ``UserProfileRepository``: Interface for user profile data operations
  - ``TestResultLocalDataRepository``: Interface for test result operations

Data Layer
^^^^^^^^^^

- **Models**:
  - ``UserProfileModel``: Data model for user profile serialization
  - ``UserTestResultLocalDataModel``: Data model for test result serialization

- **Data Sources**:
  - ``UserProfileDataSource``: Interface for user data storage operations
  - ``TestResultLocalDataSource``: Interface for test result storage operations

Database Design
---------------

The User module utilizes SQLite database with the following tables:

**userProfilesTable**:
  - userId (TEXT PRIMARY KEY)
  - nickname (TEXT)
  - sex (TEXT)
  - birthDate (TEXT)
  - educationLevel (TEXT)

**userTestResultsTable**:
  - referenceCode (TEXT)
  - userId (TEXT FOREIGN KEY)
  - date (TEXT)
  - tmtATime (REAL)
  - tmtBTime (REAL)

User Registration Flow
----------------------

1. User enters profile information (nickname, sex, birth date, education level)
2. System validates input (required fields, unique nickname)
3. On validation success, system:
   - Generates UUID for the user
   - Creates UserProfile entity
   - Converts to UserProfileModel
   - Stores in SQLite database
   - Sets as current active user

Integration Points
------------------

The User module integrates with:

- **Home Module**: For user selection and navigation to user screens
- **TMT Test Module**: For recording test results associated with users
- **Database Services**: For persistent storage of user data
- **Navigation System**: For routing between user-related screens