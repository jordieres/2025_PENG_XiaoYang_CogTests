Architecture Design
=================

Architecture Overview
-------------------

The MS-dTMT project adopts a layered architecture based on Domain-Driven Design (DDD), incorporating Clean Architecture principles. This architecture divides the application into different layers, each with specific responsibilities, ensuring code maintainability and testability.

Main Layers
----------

.. image:: _images/architecture-diagram.png
   :alt: Architecture Diagram
   :align: center

**Presentation Layer**

The presentation layer is responsible for user interfaces and user interactions. It primarily includes:

* **Views**: Flutter Widgets that render the user interface
* **Controllers**: GetX controllers that handle user input and manage UI state
* **ViewModels**: Provide data for the views, transforming domain data into a format usable by the view

**Domain Layer**

The domain layer contains business logic and rules, forming the core of the application. It primarily includes:

* **Entities**: Domain objects representing core business concepts
* **Use Cases**: Application logic implementing specific business scenarios
* **Repository Interfaces**: Abstract interfaces defining data access

**Data Layer**

The data layer is responsible for data access and storage. It primarily includes:

* **Repository Implementations**: Implementations of repository interfaces defined in the domain layer
* **Data Sources**: Local data sources (SQLite) and remote data sources (API)
* **Models**: Data models used for serialization and deserialization

Dependency Rules
--------------

Dependencies always point toward the inner layers:

* Presentation layer depends on the domain layer
* Domain layer does not depend on other layers
* Data layer depends on the domain layer (to implement its interfaces)

These dependency rules ensure the independence of the inner layer (domain layer), making business logic immune to changes in external technologies.

Folder Structure
--------------

The main folder structure of the project is as follows:

* **lib/**: Application source code

  * **app/**: Main code of the application
  
    * **features/**: Code organized by feature modules
    
      * **feature_name/**: Individual feature module
      
        * **presentation/**: UI components, controllers, and view models
        * **domain/**: Domain entities, use cases, and repository interfaces
        * **data/**: Data models, repository implementations, and data sources
        
    * **config/**: Application configuration
    * **utils/**: Utility functions and helpers
    * **shared_components/**: Shared UI components
    * **constans/**: Constant definitions
    
  * **main.dart**: Application entry point 