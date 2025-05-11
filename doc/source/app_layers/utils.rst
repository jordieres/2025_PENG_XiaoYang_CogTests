Utilities Layer
===============

Overview
--------

The Utilities layer in the MS-dTMT application provides essential supporting functionality organized into distinct categories. These utilities handle device detection, UI helpers, storage, networking, and various application-wide services that support the core features of the application.

Key Components
--------------

Services
^^^^^^^^

**LocalStorageServices**

A centralized persistent storage system using Flutter's SharedPreferences package that handles:

* **Pending TMT Test Results**
  * Saves test results when offline using ``savePendingResultList(List<String>)``
  * Retrieves pending results with ``getPendingResultList()``
  * Clears completed results with ``clearPendingResultList()``

* **Theme Settings Management**
  * Stores user theme preferences (dark/light) with ``saveThemeSettings(bool, ThemeMode)``
  * Implements system theme following with ``isFollowSystem`` flag
  * Retrieves theme settings with type-safe returns via ``loadThemeSettings()``

* **User Profile Persistence**
  * Manages current active user with ``setCurrentProfileId(String)`` and ``getCurrentProfileId()``
  * Handles user switching and deletion with appropriate cleanup
  * Provides profile context across app restarts

* **Application Configuration**
  * Stores TMT test configuration like circle count using ``saveCircleNumber(int)``
  * Retrieves configuration with defaults via ``getCircleNumber()``
  * Maintains consistent user experience across sessions

* **Storage Keys**
  * Uses standardized key constants (``_pendingResultsKey``, ``_themeKey``, etc.)
  * Implements safe type conversion and null handling
  * Ensures data integrity with appropriate storage patterns

The LocalStorageServices class is implemented as a singleton to provide application-wide access while preventing multiple instances::

    static final LocalStorageServices _localStorageServices = LocalStorageServices._internal();

    factory LocalStorageServices() {
      return _localStorageServices;
    }

    LocalStorageServices._internal();

**AppLogger**

A centralized logging system that provides:

* Named logger instances to categorize logs by component
* Multiple logging levels (fine, info, warning, severe, debug)
* Debug-mode specific logging functionality
* Stack trace and error recording for troubleshooting
* Initialization with environment-specific settings

**Database Services**

Database-related utilities including:

* UserDataBaseHelper for managing user profiles and test results
* Database migration utilities to handle schema changes
* Transaction management for data integrity

**Native API Services**

Bridges functionality to native platform APIs for device-specific features.

**WorkManagerHandler**

Manages background tasks for offline operation with:

* Task scheduling for pending test results with ``scheduleResultsSending()``
* Initialization of the worker system via ``initializeWorkManager()``
* Background task management for network operations
* Cancellation of pending tasks with ``cancelWorkTask()``
* Callback handling through the ``callbackDispatcher()`` function

Network Services
^^^^^^^^^^^^^^^^

**API Error Handling**

Implements robust error handling for network requests with:

* Error categorization (server, client, authentication, network)
* Status code interpretation
* Standardized error messages
* Error data extraction from various response formats

**API Constants**

Defines API endpoints, headers, and request configurations.

**Result Data**

Provides standardized response wrappers for network operations to ensure consistent handling of:

* Success responses with proper typing
* Error cases with contextual information
* Loading/progress states

UI Utilities
^^^^^^^^^^^^

**AppSnackbar**

Implements a custom snackbar with:

* Responsive sizing based on device type
* Consistent styling and animation
* Prevention of multiple overlapping instances
* Automatic dismissal with configurable duration

**UI Extensions**

Provides extensions for UI components to maintain consistent styling.

**Bottom Sheet**

Implements standardized bottom sheets for consistent presentation of modal content.

Mixins
^^^^^^

**NavigationMixin**

Centralizes navigation logic with methods for:

* Screen transitions between TMT test components
* User registration and profile flow navigation
* Result history access
* Practice and test mode selection
* Consistent navigation patterns throughout the app

**ValidationInputMixin**

Provides standardized form validation logic for input components.

**App Mixins**

Organizes all application mixins for easy access.

Helpers
^^^^^^^

**DeviceHelper**

Provides device detection and responsive design support with:

* Device type categorization (largeTablet, mediumTablet, smallTablet, largePhone, mediumPhone, smallPhone)
* Screen metrics for adaptive layouts
* Device orientation handling
* Initialization and recalculation functions for screen changes

**WidgetMaxWidthCalculator**

Calculates optimal component widths based on:

* Device type
* Screen orientation (portrait/landscape)
* Different scaling factors for each device category

This ensures proper content display across the wide range of devices supported by the application.

**String and Double Helpers**

Simple utilities for common string and numeric operations:

* Text formatting and manipulation
* Numeric precision control
* Type conversion

**Type Utilities**

Utilities for type checking and conversion operations.

**App Helpers**

General application utility functions used across different features.

Organization Structure
----------------------

The utils package is organized into a clear directory structure:

**/services/**
  Contains utilities for backend and system services like logging, storage, and API access.

**/ui/**
  Holds UI-related utilities including custom UI components and extensions.

**/mixins/**
  Contains reusable behavior mixins that can be incorporated into various controllers and widgets.

**/helpers/**
  Provides utility functions focused on specific tasks like device detection and component sizing.

Persistence Strategy
--------------------

The application implements a multi-layered persistence strategy:

1. **Transient Settings (SharedPreferences)**
   * Handled by LocalStorageServices for app preferences, theme settings, and active user
   * Provides quick access to lightweight configuration data
   * Used for cross-session persistence of UI state and user selections

2. **Structured Data (SQLite)**
   * Managed through UserDatabaseHelper for user profiles and test results
   * Provides relational data storage with transactions and queries
   * Supports complex data relationships and integrity constraints

3. **Pending Data Handling**
   * Combines SharedPreferences and WorkManager for offline operation
   * Stores test results when offline and schedules background sync
   * Implements automatic retry with exponential backoff

The shared preference implementation ensures critical application state persists across sessions while maintaining a responsive user experience.

Benefits of the Utilities Layer
-------------------------------

1. **Cross-Cutting Concerns**: Handles functionality that spans multiple features
2. **Consistency**: Ensures consistent behavior and appearance throughout the application
3. **Code Reuse**: Prevents duplication of common functionality
4. **Maintainability**: Centralizes core utilities for easier updates and bug fixes
5. **Abstraction**: Shields application features from low-level implementation details

The Utilities layer provides the foundation that enables the application's features to focus on their core functionality while relying on standardized utilities for common operations. This separation of concerns leads to a more maintainable and scalable codebase.