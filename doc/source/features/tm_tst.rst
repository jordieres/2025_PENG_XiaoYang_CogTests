Trail Making Test Module Overview
=================================

Overview
--------

The Trail Making Test (TMT) module is a digital implementation of a standardized cognitive assessment used to evaluate visual attention, task-switching ability, and executive function. The test consists of two parts: TMT-A (connecting numbers in sequence) and TMT-B (alternating between numbers and letters).

Module Structure
----------------

The TMT module follows the project's layered architecture with clear separation of concerns:

.. toctree::
   :maxdepth: 1
   :caption: Architectural Layers:

   tm_tst/presentation
   tm_tst/domain
   tm_tst/data

Key Features
------------

* **Dynamic Test Generation**: Creates tests with configurable number of circles (default 25 or simplified 15)
* **Practice Mode**: Allows users to practice with 9 circles before formal testing
* **Hand Selection**: Records which hand was used for test completion (left or right)
* **Comprehensive Metrics**: Collects detailed performance data including:
  * Completion time for TMT-A and TMT-B
  * Error counts (overall and for each part)
  * Lift metrics (number of times finger is lifted during test)
  * Pause metrics (number and duration of pauses)
  * Pressure and size metrics (when supported by device)
  * Circle-specific metrics (time between and inside circles)
* **Results Analysis**: Sections the test into 5 segments for detailed analysis
* **Offline Support**: Stores results locally with synchronization when online
* **Reference Code**: Links tests to specific reference codes for clinical use
* **User Profiles**: Associates tests with user profiles for longitudinal tracking

Test Flow
---------

1. **Mode Selection**: User chooses between practice and formal test modes
2. **Hand Selection**: User indicates which hand they will use
3. **TMT-A Test**: Connecting numbers in sequence (1-2-3...)
4. **Intermediate Screen**: Notification that Part A is complete
5. **TMT-B Test**: Alternating between numbers and letters (1-A-2-B...)
6. **Results Screen**: Displays completion time, errors, and other metrics
7. **Data Synchronization**: Results are saved locally and uploaded when online

UI/UX Design
------------

The TMT interface prioritizes:

* **Distraction-free Environment**: Clean interface to maintain test validity
* **Real-time Feedback**: Visual indicators for correct and incorrect connections
* **Error Handling**: Visual and logical handling of connection errors
* **Adaptability**: Responsive design for different screen sizes and orientations
* **Accessibility**: Configurable circle sizes and contrast options

Technical Implementation
------------------------

* **Responsive Circle Generation**: Dynamically positions circles based on screen dimensions
* **Connectivity Validation**: Ensures proper sequencing and detects errors
* **Touch Event Tracking**: Records detailed interaction metrics
* **Path Drawing**: Visualizes connection paths during test execution
* **Timer Management**: Precise timing of overall and segment completion
* **State Management**: Manages test flow states using GetX pattern
* **Data Persistence**: Stores results in SQLite with cloud synchronization
* **Results Reporting**: Formats data for clinical interpretation

The TMT module provides clinicians with a valid digital alternative to the traditional paper-based test while adding the benefits of precise measurement, standardized administration, and advanced performance analytics.