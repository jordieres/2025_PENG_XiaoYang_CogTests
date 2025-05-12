Presentation Layer
==================

Overview
--------

The Presentation Layer of the Home module implements the user interface components and interaction logic. It follows the GetX state management pattern to maintain a reactive UI while keeping the code clean and modular.

Screens
-------

HomePage
^^^^^^^^

The main screen of the application (``lib/app/features/home/presentation/screens/home_page.dart``):

- Serves as the application's entry point and central navigation hub
- Implements a responsive layout that adapts to different screen sizes and orientations
- Uses GetX for state management and dependency injection
- Manages system UI overlay styles for consistent theme application

Key features:
  * Profile selection interface
  * Reference code validation
  * TMT test access and configuration
  * Navigation to user data and test history screens

Components
----------

HomeHeader
^^^^^^^^^^

Header component (``lib/app/features/home/presentation/components/home_page_header.dart``):

- Displays the Madrid health logo
- Provides theme switching functionality (light/dark modes)
- Includes language selection (English, Spanish, Chinese)
- Uses SVG assets for consistent rendering across devices

SelectUserDropdown
^^^^^^^^^^^^^^^^^^

User selection component (``lib/app/features/home/presentation/components/select_user_dropdown.dart``):

- Displays current user with greeting when a profile is selected
- Shows "Create profile" prompt when no profile exists
- Opens user selection dialog for profile management
- Adapts its appearance based on screen orientation
- Automatically refreshes after profile changes
- Observes route changes to detect new user registrations

ReferenceCodeInput
^^^^^^^^^^^^^^^^^^

Reference code component (``lib/app/features/home/presentation/components/reference_code_input.dart``):

- Implements a dual-field input for reference code format (prefix-suffix)
- Provides validation feedback with error messaging
- Uses custom text formatters for input standardization
- Features edit and confirm actions
- Adapts its appearance based on validation state and active status
- Implements focus management for smooth input experience

TmtTestButtonCard
^^^^^^^^^^^^^^^^^

TMT test button component (``lib/app/features/home/presentation/components/tmt_test_button_card.dart``):

- Provides prominent button for starting the TMT test
- Includes dropdown to select circle count (15 or 25 circles)
- Offers help dialog explaining circle count options
- Adapts its appearance based on reference code validation status
- Saves circle count preference for future sessions
- Features responsive layout for different screen sizes

HomeCardButton
^^^^^^^^^^^^^^

Card button component (``lib/app/features/home/presentation/components/home_card_button.dart``):

- Reusable button component with card-like appearance
- Supports different height configurations
- Implements touch feedback effects
- Displays lock icon in disabled state
- Adapts appearance based on theme (light/dark)

Controllers
-----------

ReferenceCodeController
^^^^^^^^^^^^^^^^^^^^^^^

Reference validation controller (``lib/app/features/home/presentation/controllers/reference_code_controller.dart``):

- Manages reference code validation state
- Coordinates with domain layer validation use case
- Maintains validation flags (isValidating, isValidated)
- Stores validated reference code
- Provides error message handling and display
- Implements validation reset functionality

SelectUserProfileController
^^^^^^^^^^^^^^^^^^^^^^^^^^^

User profile controller (``lib/app/features/home/presentation/controllers/select_user_profile_controller.dart``):

- Extends base UserProfileController with home-specific functionality
- Maintains list of available user profiles
- Handles current profile selection and switching
- Provides profile search capability
- Manages profile deletion with confirmation
- Shows success/error feedback via snackbars
- Implements refresh mechanism after profile changes

Bindings
--------

HomeScreenBinding
^^^^^^^^^^^^^^^^^

Home screen binding (``lib/app/features/home/presentation/binding/home_screen_binding.dart``):

- Minimal implementation for core home dependencies

ReferenceValidationBinding
^^^^^^^^^^^^^^^^^^^^^^^^^^

Reference validation binding (``lib/app/features/home/presentation/binding/reference_validation_biding.dart``):

- Sets up database helper
- Configures test result data source
- Initializes reference validation repository
- Sets up validation use case
- Creates reference code controller

SelectUserBinding
^^^^^^^^^^^^^^^^^

User selection binding (``lib/app/features/home/presentation/binding/select_user_profile_binding.dart``):

- Sets up database helper if not already registered
- Configures user profile data source
- Initializes user profile repository
- Creates select user controller instance

The presentation layer implements a cohesive, responsive interface while maintaining clean separation from business logic and data access layers.