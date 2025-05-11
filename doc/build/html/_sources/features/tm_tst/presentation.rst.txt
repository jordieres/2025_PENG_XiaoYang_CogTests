Presentation Layer
==================

Overview
--------

The Presentation Layer of the TMT module implements the user interface and interaction patterns for administering the Trail Making Test. It uses GetX for state management and follows a clean architecture pattern with clear separation between UI, state management, and business logic.

Components
----------

Screens
^^^^^^^

**TmtTestHelpPage**

Provides test instructions with contextual guidance:

- Separate help content for TMT-A and TMT-B tests
- Clear explanation of test objectives and procedures
- Option to proceed to practice or return to previous screen
- Support for different help modes (TMT_TEST_A, TMT_TEST_B, TMT_PRACTICE_A, TMT_PRACTICE_B)

**TmtTestPracticePage**

A training environment with simplified test parameters:

- Implements practice mode with 9 circles instead of 25
- Supports three practice modes (TMT_A_ONLY, TMT_B_ONLY, TMT_A_THEN_B)
- Provides interactive feedback during practice
- Allows unlimited attempts to reinforce proper test execution

**TmtTestPage**

The formal test execution screen:

- Implements full 15 or 25 circle test based on configuration
- Tracks timer data and displays in app bar
- Handles test state transitions between parts A and B
- Manages user interactions via gesture detection
- Adapts to orientation changes while preserving test state

**TmtResultsScreen**

Presents comprehensive test results:

- Displays completion times and error counts for both test parts
- Shows session count for longitudinal tracking
- Adapts layout based on device orientation and screen size
- Includes scrolling for compact screens with scroll indicator
- Prevents navigation back to preserve test integrity

**TmtSelectModePracticeOrTest**

Interface for selecting test mode and configuration:

- Offers choice between practice and formal test
- Displays informational dialogs explaining each mode
- Initiates hand selection dialog for formal tests
- Uses responsive layout for different orientations

Controllers
^^^^^^^^^^^

**BaseTmtTestFlowController**

Abstract base controller defining the test flow interface:

- Manages test state transitions (READY, TMT_A_IN_PROGRESS, TMT_A_COMPLETED, TMT_B_IN_PROGRESS, TEST_COMPLETED)
- Defines abstract methods for concrete implementations
- Maintains the metrics controller for performance tracking
- Handles test initialization and configuration loading

**TmtTestFlowStateController**

Implements formal test flow management:

- Controls state transitions for the complete TMT test
- Preserves metrics from TMT-A for comprehensive reporting
- Initializes game configuration with user preferences
- Manages test metrics throughout the test execution

**TmtPracticeFlowController**

Specialized controller for practice mode:

- Simplifies test configuration for practice sessions
- Resets metrics between practice attempts
- Uses practice-specific circle counts and parameters
- Maintains clean state separation from formal tests

**TmtResultReportController**

Manages test result submission and reporting:

- Processes metrics into reportable result data
- Handles API communication for result submission
- Manages local result storage when offline
- Tracks request states (loading, success, error)

Components
^^^^^^^^^^

**TmtGameBoardController**

Core UI component managing the interactive test board:

- Renders circles based on test configuration
- Handles user touch interactions (pan start, update, end)
- Validates connections and detects errors
- Provides visual feedback for connections and errors
- Supports "cheat mode" for debugging and demonstrations
- Adapts to orientation changes and screen dimensions

**TmtPainter**

Custom painter for rendering the test interface:

- Draws circles with correct styling based on state
- Renders connection paths as user interacts
- Provides visual feedback for errors
- Handles start/end circle special styling
- Implements proper z-ordering of visual elements
- Optimizes redrawing for performance

**TmtResultCard**

Displays test results in a structured card format:

- Shows test part title (TMT A or TMT B)
- Presents duration and error count
- Adapts layout based on available space
- Uses responsive sizing for different devices
- Implements consistent styling with app theme

**TmtSelectHandDialog**

Dialog for selecting which hand will be used:

- Presents clear options for left or right hand
- Uses intuitive hand emojis for visual clarity
- Captures selection for result interpretation
- Ensures hand usage is recorded for clinical validity

**TmtCustomAppBar**

Specialized app bar for the test interface:

- Displays accurate timer during test execution
- Shows contextual help button with appropriate handling
- Adapts to test state changes
- Provides consistent navigation across test phases

Bindings
^^^^^^^^

**TmtTESTBinding**

Manages dependencies for formal test mode:

- Registers TmtTestFlowStateController
- Ensures proper initialization of test environment

**TmtTESTPracticeBinding**

Handles practice mode dependencies:

- Registers TmtPracticeFlowController
- Sets up practice-specific configuration

**TmtResultBinding**

Sets up result reporting dependencies:

- Registers repositories and services for result handling
- Configures result reporting use cases
- Establishes pending result management

**TmtGameConfigBinding**

Manages test configuration dependencies:

- Registers configuration repositories
- Sets up use cases for configuration persistence
- Ensures test parameters are properly loaded

UI Flows
^^^^^^^^

**Test Help Flow**

1. User views contextual help for selected test part
2. User can proceed to practice or return to selection screen
3. Navigation maintains proper context between screens

**Practice Flow**

1. User selects practice mode
2. Practice test is generated with simplified parameters
3. User completes practice with unlimited attempts
4. Dialogs provide guidance and transition options

**Formal Test Flow**

1. User selects test mode and hand preference
2. TMT-A is generated and timed
3. On completion, transition dialog is displayed
4. TMT-B is generated and timed
5. Results screen shows comprehensive metrics

**Responsiveness**

The presentation layer implements several responsive design patterns:

- Adaptive layouts based on device size and orientation
- Dynamic calculation of circle positions and sizes
- Orientation-aware component arrangements
- Screen-size dependent spacing and margins
- Tablet-specific optimizations for larger displays

This comprehensive presentation layer delivers a clinically valid yet user-friendly implementation of the Trail Making Test that maintains assessment integrity while providing a smooth, intuitive user experience across different devices.