Domain Layer
============

Overview
--------

The Domain Layer of the TMT module contains the business logic and rules for the Trail Making Test, independent of UI implementation and data sources. It defines entities, repository interfaces, and use cases that encapsulate the core functionality of the cognitive assessment.

Components
----------

Entities
^^^^^^^^

**TmtGameCircle**

Represents an individual circle in the test:

- Position (Offset) on the test board
- Text content (number or letter)
- Order within the sequence
- Type indicator (isNumber property)
- Methods for detecting point containment
- First circle status checking

**TmtGameVariable**

Contains static configuration parameters for the test:

- Circle radius and spacing values
- Connection distances and tolerances
- Board margins and visual parameters
- Error duration constants
- Default and alternative circle counts (25 or 15)
- Methods for calculating optimal parameters based on screen size
- Functions for practice mode vs. test mode setup

**TmtGameHandUsed**

Enum representing which hand was used during the test:

- LEFT ("I")
- RIGHT ("D")
- Value mapping for data persistence
- Factory method for reconstructing from stored values

**TmtGameInitData**

Encapsulates initial test configuration:

- Reference code identifier
- Hand used during the test
- Immutable structure for clean data passing

**TmtGameResultData**

Comprehensive result entity containing all test metrics:

- Test configuration data
- Timestamps for test parts
- Completion times for TMT-A and TMT-B
- Error counts (total, part A, part B)
- Lift and pause metrics
- Pressure and size measurements
- Device information
- Sectional scores (A1-A5, B1-B5)
- Methods for construction from metrics controller

Metrics Entities
^^^^^^^^^^^^^^^^

**TmtMetricsController**

Central metrics collection and calculation entity:

- Captures all test performance data
- Manages test timestamps and transitions
- Tracks errors and their distribution
- Maintains circle connection metrics
- Handles test event callbacks (start, end, pan actions)
- Provides copy mechanism for state preservation
- Calculates derived metrics and scores

**TmtTestTimeMetric**

Handles timing-related metrics:

- Records test start and end times
- Tracks segment completion times
- Calculates overall and segment durations
- Divides test into five equal sections for analysis
- Provides standardized time measurements

**TmtTestLiftMetric**

Tracks finger lift events:

- Counts number of lifts during test
- Measures duration of each lift
- Calculates average lift duration
- Provides insights into test continuity

**TmtTestPauseMetric**

Analyzes pauses during test execution:

- Detects pauses based on position and time threshold
- Counts pause occurrences
- Measures pause durations
- Calculates average pause duration
- Provides insights into hesitation patterns

**TmtBMetrics**

Specialized metrics for TMT-B alternation patterns:

- Tracks transitions between numbers and letters
- Measures time and rate before letters
- Measures time and rate before numbers
- Calculates average drawing rates
- Analyzes cognitive switching efficiency

**TmtCircleMetrics**

Analyzes drawing patterns between and inside circles:

- Measures time spent between circles
- Tracks drawing paths inside circles
- Calculates drawing rates and times
- Provides insights into motor control and planning
- Distinguishes between connection types

**TmtPressureSizeMetric**

Captures touch pressure and size data (when available):

- Records pressure variations during drawing
- Tracks touch size measurements
- Calculates average pressure and size
- Handles devices without pressure/size capabilities
- Provides insights into motor control

Use Cases
^^^^^^^^^

**TmtGameConfigUseCase**

Manages test configuration persistence and retrieval:

- Saves circle number preference
- Retrieves stored configuration
- Loads configuration into active test
- Handles default values when needed

**TmtGameCalculate**

Implements geometric calculations for test validation:

- Determines if points are inside circles
- Validates connection distances
- Calculates board boundaries
- Computes closest points on circle perimeters
- Ensures spatial accuracy of interactions

**ReportTmtResultUseCase**

Handles test result submission and storage:

- Transforms metrics into reportable formats
- Submits results to remote server
- Handles offline storage for pending results
- Manages synchronization attempts

**PendingResultUseCase**

Manages results when network is unavailable:

- Saves pending results locally
- Retrieves and processes pending results
- Attempts resubmission when network available
- Handles successful submission cleanup

**TmtResultScreenResponsiveCalculator**

Calculates optimal layouts for result presentation:

- Determines spacing based on device properties
- Calculates card dimensions and margins
- Optimizes layouts for different orientations
- Ensures consistent presentation across devices

Repositories (Interfaces)
^^^^^^^^^^^^^^^^^^^^^^^^^

**TmtResultRepository**

Interface for result data operations:

- Defines methods for reporting test results
- Abstracts data persistence implementation
- Enables dependency inversion

**TmtGameConfigRepository**

Interface for configuration persistence:

- Defines methods for saving circle count preference
- Defines methods for retrieving settings
- Abstracts storage mechanism

**PendingResultRepository**

Interface for managing offline results:

- Defines methods for saving pending results
- Defines methods for retrieving pending results
- Defines methods for deleting resolved results
- Abstracts synchronization mechanisms

Value Objects and Constants
^^^^^^^^^^^^^^^^^^^^^^^^^^^

**MetricStaticValues**

Contains constants for metric calculations:

- Pause threshold duration (100ms)
- Position tolerance values
- Metric calculation thresholds
- Section boundary definitions
- Sentinel values for special cases

**TmtGameType**

Enum for test types:

- TMT_TEST_A
- TMT_TEST_B
- TMT_PRACTICE_A
- TMT_PRACTICE_B
- TMT_BOTH_PRACTICE

**TmtGameCircleTextType**

Enum for circle content types:

- NUMBER (for TMT-A)
- NUMBER_WITH_LETTER (for TMT-B)

Domain Services
^^^^^^^^^^^^^^^

**RandomGridSampler**

Generates spatially distributed points for circle placement:

- Creates grid-based distribution algorithm
- Ensures minimum distance between points
- Adapts to available screen space
- Handles fallback strategies when optimal placement fails
- Provides deterministic yet apparently random layouts

**ReorderCircles**

Optimizes circle ordering for valid test sequences:

- Reorders circles based on connectable paths
- Ensures paths don't overlap excessively
- Optimizes for clean visual presentation
- Applies clinical guidelines for test validity
- Handles regeneration of problematic placements

**GenerateCircleWithData**

Creates circle entities with appropriate properties:

- Assigns numbers or alternating numbers/letters
- Generates correct text representations
- Configures circle properties based on test type
- Creates complete set of test circles

Benefits of the Domain Layer
----------------------------

1. **Clinical Validity**: Ensures the digital implementation follows standardized assessment protocols
2. **Test Integrity**: Guarantees consistent test parameters and scoring
3. **Separation of Concerns**: Isolates core test logic from presentation details
4. **Enhanced Metrics**: Collects detailed metrics impossible in paper-based tests
5. **Algorithmic Purity**: Contains complex test generation and validation logic in testable entities

The domain layer provides a robust foundation for a clinically valid digital implementation of the Trail Making Test while enabling enhanced data collection and analysis beyond what traditional paper-based tests can offer.