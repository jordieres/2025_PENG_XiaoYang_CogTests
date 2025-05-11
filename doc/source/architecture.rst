Feature-First Architecture
===========================

Architecture Overview
---------------------

The MS-dTMT project implements a Feature-First Architecture that incorporates Clean Architecture principles. In this approach, code is primarily organized by features rather than technical layers, promoting cohesion and modularity. Within each feature, we follow a layered structure based on Clean Architecture concepts.

The application uses GetX as the primary framework for state management, dependency injection, and navigation, which integrates seamlessly with this architectural approach.

Main Organization
------------------

.. image:: _images/architecture-diagram.png
   :alt: Architecture Diagram
   :align: center

**Feature-First Structure**

The codebase is organized by features, where each feature contains its own:

* Presentation layer (UI components)
* Domain layer (business logic)
* Data layer (data access)

This organization makes the codebase more navigable, as related code is grouped together regardless of its technical role.

**Clean Architecture Layers**

Within each feature, we follow Clean Architecture principles with distinct layers:

**Presentation Layer**

* **Views**: Flutter Widgets that render the user interface
* **Controllers**: GetX controllers that handle user input and manage UI state using reactive programming
* **Bindings**: GetX bindings that manage dependency injection for controllers and services

**Domain Layer**

* **Entities**: Domain objects representing core business concepts and data structures
* **Use Cases**: Application-specific business rules encapsulating all business logic
* **Repository Interfaces**: Abstract definitions declaring data access methods without implementation details

**Data Layer**

* **Repository Implementations**: Concrete implementations of the repository interfaces defined in the domain layer
* **Data Sources**: Components that interact with external data providers:
    * Local data sources (SQLite, SharedPreferences)
    * Remote data sources (REST API)
* **Models**: Data transfer objects (DTOs) that handle serialization and deserialization

Dependency Rules
----------------

The architecture follows strict dependency rules to maintain separation and testability:

* Presentation layer depends on the domain layer
* Domain layer does not depend on any outer layers
* Data layer depends on the domain layer (to implement its interfaces)

These dependencies always point inward, ensuring that inner layers remain independent of external frameworks and implementation details.

GetX Integration
-----------------

GetX is integrated throughout the application:

* **State Management**: Controllers use Rx variables and streams for reactive state updates
* **Dependency Injection**: Services and controllers are registered and accessed through GetX service locator
* **Route Management**: Navigation between screens is handled with GetX named routes
* **Bindings**: Components are initialized and injected when routes are accessed

Folder Structure
----------------

The project follows a feature-first organization:

* **lib/**: Application source code

  * **app/**: Main code of the application
  
    * **features/**: Code organized by feature modules
    
      * **tm_tst/**: Trail Making Test feature
        * **presentation/**: UI components, screens, controllers
        * **domain/**: Entities, use cases, repository interfaces
        * **data/**: Models, repository implementations, data sources
      
      * **user/**: User management feature
        * *(same structure as above)*
      
      * **home/**: Home screen and navigation feature
        * *(same structure as above)*
        
    * **config/**: Application configuration
      * **routes/**: Route definitions
      * **themes/**: Theme configuration
      * **translation/**: Localization resources
      
    * **utils/**: Utility functions and helpers
      * **services/**: Common services (network, storage)
      * **helpers/**: Helper functions and extensions
      * **mixins/**: Shared functionality via mixins
      
    * **shared_components/**: Reusable UI components
    * **constans/**: Constant definitions
    
  * **main.dart**: Application entry point

Benefits of Feature-First Architecture
---------------------------------------

This architectural approach offers several advantages:

* **Cohesion**: Related code stays together regardless of its layer
* **Discoverability**: Easier to navigate and find relevant code
* **Scalability**: New features can be added without modifying existing ones
* **Maintainability**: Changes to one feature don't affect others
* **Teamwork**: Different teams can work on different features simultaneously
* **Testability**: Features can be tested in isolation