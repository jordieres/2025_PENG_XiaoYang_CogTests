Data Layer
==========

Overview
--------

The Data Layer of the TMT module is responsible for persistence, retrieval, and communication with external services. It implements the repository interfaces defined in the domain layer, handling local storage, API communication, and offline synchronization strategies to ensure test results are reliably captured and preserved.

Components
----------

Repository Implementations
^^^^^^^^^^^^^^^^^^^^^^^^^^

**TmtResultRepositoryImpl**

Implements TmtResultRepository interface for reporting test results:

- Retrieves current user profile for result association
- Transforms and submits test results to API service
- Handles error cases and logging
- Delegates to appropriate data sources
- Returns properly structured result data

**PendingResultRepositoryImpl**

Implements PendingResultRepository interface for offline result management:

- Saves test results locally when network unavailable
- Retrieves pending results for later synchronization
- Manages deletion of successfully reported results
- Maintains timestamp information for synchronization priority
- Interfaces with LocalStorageServices for persistence

**TmtGameConfigRepositoryImpl**

Implements TmtGameConfigRepository interface for test configuration:

- Stores user preferences for circle count
- Retrieves configuration parameters
- Uses LocalStorageServices for persistent settings
- Manages default values when settings not found

Models
^^^^^^

**TmtResultModel**

Data transfer model for test results:

- Maps domain entity properties to API-compatible format
- Handles date formatting for server requirements
- Manages optional fields based on circle count
- Converts domain metrics to transferable format
- Handles serialization to JSON for API requests

**TmtUserModel**

Data transfer model for user information:

- Maps user profile data to required API format
- Formats demographic information for result context
- Handles date formatting for birthdate
- Provides conversion between domain and API formats

**PendingResultData**

Model for storing offline results:

- Contains JSON representations of result and user data
- Stores timestamp for synchronization ordering
- Provides extraction methods for key information
- Simplifies serialization for local storage

Data Sources
^^^^^^^^^^^^

**GenerateCircleWithData**

Data source for circle generation:

- Creates circles with appropriate labels based on test type
- Handles number-only (TMT-A) or alternating number-letter (TMT-B) generation
- Assigns correct sequence order values
- Maps raw position data to domain entities

**RandomGridSampler**

Advanced data source for optimal circle positioning:

- Implements grid-based placement algorithm
- Ensures minimum distances between circle centers
- Adapts to available screen dimensions
- Provides fallback strategies for challenging constraints
- Optimizes circle distribution for valid test patterns

**ReorderCircles**

Data source for optimizing circle sequences:

- Analyzes potential connection paths between circles
- Reorders circles to create valid test sequences
- Identifies and resolves circle visibility and accessibility issues
- Implements optimal distance calculation strategies
- Handles regeneration of problematic placements

**SimpleGenerateRandomCircle**

Basic circle generation fallback:

- Provides simplified random placement algorithm
- Ensures minimum distance between circles
- Validates circle positions against boundaries
- Used as fallback when advanced algorithms fail

API Services
^^^^^^^^^^^^

The TMT module interacts with these API services (via dependency injection):

**RestApiServices**

- `reportTmtResults`: Sends test results to the server
- `reportTmtResultsWithJson`: Alternative payload format for sending results
- `validateReferenceCode`: Verifies that a reference code is valid

These services are injected into the repositories rather than being directly implemented in the TMT module.

Local Storage
^^^^^^^^^^^^^

The module relies on `LocalStorageServices` with these specific methods:

- `getPendingResultList`: Retrieves stored pending results
- `savePendingResultList`: Persists pending results
- `clearPendingResultList`: Removes all pending results
- `saveCircleNumber`: Stores user preference for circle count
- `getCircleNumber`: Retrieves circle count configuration

Work Management
^^^^^^^^^^^^^^^

The data layer interacts with the `WorkManagerHandler` to:

- Schedule background synchronization of pending results
- Cancel scheduled tasks when no longer needed
- Manage network-dependent operations efficiently
- Enable offline-first operation with reliable sync

Offline Strategy
^^^^^^^^^^^^^^^^

The TMT module implements a robust offline-first approach:

1. Results are always saved locally first
2. If network is available, immediate synchronization is attempted
3. For offline usage, results are stored in pending queue
4. Background work is scheduled for later synchronization
5. On successful sync, pending entries are removed
6. Network errors trigger re-queuing for later attempts

Data Flow
^^^^^^^^^

1. **Test Completion**:
   - TmtMetricsController collects performance data
   - TmtGameResultData is constructed with comprehensive metrics
   - TmtResultModel transforms domain data to transferable format

2. **Result Submission**:
   - ReportTmtResultUseCase invokes repository implementation
   - Current user profile is retrieved and transformed to TmtUserModel
   - Result is submitted to API service

3. **Offline Handling**:
   - Network errors are detected and handled
   - PendingResultUseCase saves result for later submission
   - WorkManagerHandler schedules background synchronization

4. **Configuration Management**:
   - User preferences for circle count are persisted
   - TmtGameConfigUseCase retrieves settings before test generation
   - Default values are used when settings are not available

Security Considerations
^^^^^^^^^^^^^^^^^^^^^^^

- User data is associated with results only at submission time
- Demographic data is limited to necessary clinical context
- Local result storage uses platform-appropriate encryption
- Network transmission uses secure connection mechanisms
- Personal identifiers are managed through reference codes

Performance Optimizations
^^^^^^^^^^^^^^^^^^^^^^^^^

- Efficient local storage structure for quick retrieval
- Batch processing of pending results during synchronization
- Minimal storage footprint for offline data
- Lazy loading of historical results
- Efficient serialization formats for persistence

The data layer ensures that valuable clinical assessment data is reliably persisted, properly formatted for analysis, and securely transmitted to backend systems while maintaining a seamless user experience regardless of network availability.