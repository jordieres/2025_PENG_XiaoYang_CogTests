Data Layer
==========

Overview
--------

The Data Layer in the Home module is responsible for implementing the repository interfaces defined in the domain layer. It handles the actual data operations, whether retrieving from local storage, communicating with APIs, or processing in-memory data.

Repository Implementations
--------------------------

ReferenceValidationRepositoryImpl
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Implementation of reference validation repository (``lib/app/features/home/data/repositories/reference_validation_repository_impl.dart``):

- Implements ``ReferenceValidationRepository`` interface
- Coordinates between local and remote data sources:
  * Uses ``TestResultLocalDataSource`` for local validation
  * Uses ``RestApiServices`` for remote validation

- Constructor receives dependencies through injection:

.. code-block:: dart

   ReferenceValidationRepositoryImpl({
     required this.testResultDataSource,
     required this.apiServices,
   });

- Implements local validation method:

.. code-block:: dart

   @override
   Future<bool> isReferenceCodeUsedLocally(String referenceCode) async {
     return await testResultDataSource.isReferenceCodeUsed(referenceCode);
   }

- Implements remote validation method:

.. code-block:: dart

   @override
   Future<ResultData> validateReferenceCodeRemotely(String referenceCode) async {
     return await apiServices.validateReferenceCode(referenceCode);
   }

- Provides clean separation between domain and data source access
- Handles potential errors in data operations
- Returns properly formatted results for domain layer consumption

Data Sources
------------

The Home module utilizes several data sources to fulfill its repository requirements:

TestResultLocalDataSource
^^^^^^^^^^^^^^^^^^^^^^^^^

The local data source for test results (implemented in User module):

- Provides methods for managing test results:
  * ``getTestResultsByUserId``: Retrieves tests by user ID
  * ``getTestResultsByNickname``: Retrieves tests by nickname
  * ``saveTestResult``: Saves test result to local database
  * ``isReferenceCodeUsed``: Checks if reference code is already used

- Uses SQLite database for persistent storage
- Manages database queries and transactions

RestApiServices
^^^^^^^^^^^^^^^

The remote API service (shared service):

- Provides REST API communication:
  * ``validateReferenceCode``: Validates reference codes against server
  * Other API methods for different features

- Handles HTTP requests and responses
- Manages API errors and timeouts
- Uses Dio for HTTP client functionality
- Implements retry logic and error handling

Data Flow
---------

The data flow for reference code validation follows these steps:

1. Application calls ``ValidateReferenceCodeUseCase.execute()``
2. Use case calls ``ReferenceValidationRepository.isReferenceCodeUsedLocally()``
3. Repository implementation calls ``TestResultLocalDataSource.isReferenceCodeUsed()``
4. If code is not used locally, use case calls ``ReferenceValidationRepository.validateReferenceCodeRemotely()``
5. Repository implementation calls ``RestApiServices.validateReferenceCode()``
6. API service makes HTTP request to validation endpoint
7. Response is processed and returned through the layers
8. Use case creates appropriate ``ReferenceValidationResult`` based on responses

This layered approach ensures clean separation of concerns, with each component handling its specific responsibility in the data flow.

Database Structure
------------------

The reference validation functionality relies on the user test results table:

.. code-block:: sql

   CREATE TABLE user_test_results(
     referenceCode TEXT PRIMARY KEY,
     userId TEXT NOT NULL,
     date TEXT NOT NULL,
     tmtATime REAL NOT NULL,
     tmtBTime REAL NOT NULL,
     FOREIGN KEY (userId) REFERENCES user_profiles(userId)
   )

This table stores completed tests and allows the repository to check if a reference code has already been used.

The data layer effectively implements the interfaces defined in the domain layer while handling the complexities of data access, storage, and remote communication.