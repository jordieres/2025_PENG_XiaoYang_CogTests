Project Overview
================

Project Introduction
--------------------

MS-dTMT is a cognitive testing application developed with Flutter, primarily used for conducting Digital Trail Making Tests. The application provides a solution for standardized cognitive assessment on mobile devices, enabling researchers and clinicians to conveniently collect cognitive function data.

Main Features
-------------

* **Cognitive Testing**: Implementation of standardized cognitive assessment tools like the Trail Making Test (TMT)
* **User Management**: Support for user registration, login, and profile management
* **Data Collection**: Collection of test data and visualization of results
* **Offline Functionality**: Support for testing without an internet connection
* **Data Synchronization**: Synchronization of data to the server when an internet connection is available

Technology Stack
----------------

* **Frontend Framework**: Flutter (Dart)
* **State Management**: GetX and Provider
* **Data Storage**: SQLite (local) and cloud database
* **Network Requests**: Dio
* **Localization**: intl package for multi-language support
* **Dependency Injection**: GetX service management

Project Architecture
--------------------

The project employs a clear layered architecture based on Domain-Driven Design (DDD) principles:

* **Presentation Layer**: Contains UI components, controllers, and view models
* **Domain Layer**: Contains business logic, entities, and use cases
* **Data Layer**: Contains data sources, models, and repository implementations

The overall project structure follows a modular organization by feature, where each feature is independent and contains its complete MVC/MVVM structure. 