Trail Making Test Module
=====================

Overview
--------

The Trail Making Test (TMT) module is a core functionality of the application, implementing a standardized cognitive assessment tool. This test is used to evaluate the user's visual attention, task-switching ability, and executive function, divided into two parts: TMT-A (connecting numbers) and TMT-B (alternately connecting numbers and letters).

Module Structure
---------------

The TMT module follows the project's layered architecture, including the following components:

**Presentation Layer**

* **TMTScreen**: The main interface for the test, including start, instruction, and testing phases
* **TMTController**: Manages the test process and state
* **TMTResultScreen**: Displays test results and statistics
* **ViewModels**: Provides test data and state

**Domain Layer**

* **TMTEntity**: Represents the domain object for the test
* **TMTResult**: Represents the domain object for test results
* **TMTUseCase**: Contains business logic for the test, such as test generation and scoring
* **TMTRepository Interface**: Defines data access abstractions

**Data Layer**

* **TMTRepositoryImpl**: Implements the repository interface defined in the domain layer
* **TMTModel**: Data model for serialization and deserialization
* **Data Sources**: Local storage and remote API

Main Features
------------

* **Test Generation**: Dynamically generates test content based on configuration
* **Instructions Tutorial**: Provides pre-test guidance to users
* **Test Execution**: Implements test interaction logic and timing
* **Result Calculation**: Calculates various metrics of user performance
* **Data Storage**: Saves test results and allows historical viewing
* **Result Analysis**: Provides visualization of test results

Test Flow
--------

1. **Introduction Page**: Explains the purpose and method of the test to the user
2. **Practice Phase**: Allows the user to become familiar with the test operation
3. **TMT-A Test**: Requires the user to connect numbers in sequence (1-2-3...)
4. **TMT-B Test**: Requires the user to alternately connect numbers and letters (1-A-2-B...)
5. **Results Page**: Displays the user's completion time, number of errors, and other metrics

Key Classes and Methods
---------------------

.. code-block:: dart

   // TMTController: Manages the test state and logic
   class TMTController extends GetxController {
     final TMTUseCase _tmtUseCase;
     
     // Observable state variables
     final RxInt currentPhase = 0.obs; // 0:Introduction, 1:Practice, 2:TMT-A, 3:TMT-B, 4:Results
     final RxList<TMTItem> items = <TMTItem>[].obs;
     final RxList<TMTConnection> connections = <TMTConnection>[].obs;
     final Rx<TMTResult> result = TMTResult.empty().obs;
     final RxBool isTestRunning = false.obs;
     final RxInt elapsedTime = 0.obs;
     
     // Test timer
     Timer? _timer;
     
     TMTController(this._tmtUseCase);
     
     // Start the test
     void startTest() {
       isTestRunning.value = true;
       _startTimer();
       // Generate test items
       items.value = _tmtUseCase.generateItems(currentPhase.value);
     }
     
     // Handle user tapping on an item
     void handleItemTap(TMTItem item) {
       // Implement connection logic and validity checks
     }
     
     // Complete the current test phase
     void completePhase() {
       _stopTimer();
       // Save current phase results
       // Prepare for the next phase or end the test
     }
     
     // Manage test timer
     void _startTimer() {
       _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
         elapsedTime.value += 100;
       });
     }
     
     void _stopTimer() {
       _timer?.cancel();
       _timer = null;
     }
   }

User Interface
------------

The TMT test interface is specially designed to ensure:

* Clear instructions and visual cues
* Intuitive interaction methods
* Responsive layout adapting to different device sizes
* Reduction of distractions and interference factors
* Precise timing and feedback

Data Processing
-------------

Test results include but are not limited to the following metrics:

* Completion time (milliseconds)
* Number of errors
* Number of correct connections
* Reaction time variability
* Overall score and standardized scores

This data is processed and stored in the local database, and synchronized to the server with user consent. 