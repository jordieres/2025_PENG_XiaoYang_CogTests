Home Module
===========

Overview
--------

The Home module is the main interface after user login, providing entry points and navigation for the application's main functions. It displays available cognitive tests, user information, and other important features.

Module Structure
---------------

The Home module follows the project's layered architecture, including the following components:

**Presentation Layer**

* **HomeScreen**: Main page interface, containing navigation menus and feature cards
* **HomeController**: Manages the home page state and user interactions
* **Widget Components**: Various UI components such as cards, buttons, and list items

**Domain Layer**

* **Use Cases**: Business logic for retrieving user data, test lists, etc.
* **Entities**: Domain objects such as User, Test, etc.

**Data Layer**

* **Repository Implementations**: Implements data access logic
* **Data Sources**: Local and remote data sources

Main Features
------------

* **Test List**: Displays available cognitive tests, including completion status and results
* **User Information**: Shows basic information and statistics for the current user
* **Navigation**: Provides navigation to other functional modules
* **Notifications**: Displays system notifications and reminders

Interface Components
------------------

The home interface includes the following main components:

* **AppBar**: Displays the application title, user avatar, and settings button
* **Test Cards**: Shows available cognitive tests, including icons, names, and descriptions
* **Bottom Navigation Bar**: Switches between different views
* **User Summary Card**: Displays the user's test history and statistics

Code Example
-----------

.. code-block:: dart

   // HomeController: Manages the home page state and logic
   class HomeController extends GetxController {
     final UserUseCase _userUseCase;
     final TestsUseCase _testsUseCase;
     
     // Observable state variables
     final Rx<User> user = User.empty().obs;
     final RxList<Test> availableTests = <Test>[].obs;
     final RxBool isLoading = false.obs;
     
     HomeController(this._userUseCase, this._testsUseCase);
     
     // Initialize controller
     @override
     void onInit() {
       super.onInit();
       _loadInitialData();
     }
     
     // Load initial data
     Future<void> _loadInitialData() async {
       isLoading.value = true;
       try {
         user.value = await _userUseCase.getCurrentUser();
         availableTests.value = await _testsUseCase.getAvailableTests();
       } catch (e) {
         // Handle errors
       } finally {
         isLoading.value = false;
       }
     }
     
     // Navigate to test page
     void navigateToTest(Test test) {
       Get.toNamed('/test/${test.id}');
     }
   }

Implementation Details
--------------------

The Home module uses GetX for state management and dependency injection. The UI follows Material Design language, ensuring a good user experience and consistent appearance. The home page uses a reactive programming model, enabling the UI to automatically respond to state changes. 