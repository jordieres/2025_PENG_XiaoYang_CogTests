Splash Module
=============

Overview
--------

The Splash module is the first page displayed when the application starts, responsible for initializing the application, including checking user login status, loading necessary configurations and resources, and displaying the application's brand identity.

Module Structure
----------------

The Splash module follows the project's layered architecture, including the following components:

**Presentation Layer**

* **SplashScreen**: Displays the application's startup screen
* **SplashController**: Controls the startup process and handles navigation logic

**Domain Layer**

* **Initialization Use Case**: Responsible for application initialization logic

**Data Layer**

* **Local Storage Access**: Checks user login status and application configuration

Main Features
-------------

* **Application Initialization**: Loads configurations and resources required by the application
* **Authentication Check**: Verifies if the user is already logged in
* **Navigation Logic**: Navigates to the appropriate page based on user status (such as login page or homepage)
* **Brand Display**: Showcases the application's brand identity and startup animation

Key Classes and Methods
-----------------------

.. code-block:: dart

   // SplashController: Manages the splash screen logic
   class SplashController extends GetxController {
     // Initialization method, called when the controller is created
     void onInit() {
       super.onInit();
       // Start the initialization process
       _initializeApp();
     }
     
     // Handle application initialization
     Future<void> _initializeApp() async {
       // Check user login status, load necessary resources and configurations
       // Navigate to the appropriate page based on status
     }
   }

Implementation Details
----------------------

The splash page uses Flutter's animation capabilities to create a smooth brand presentation experience. Through GetX's delayed navigation functionality, it automatically transitions to the next page after completing the necessary initialization work. 