Domain Layer
============

Overview
--------

The Domain Layer of the Home module contains the business logic and rules that are independent of UI implementation and data sources. It defines entities, repository interfaces, and use cases that encapsulate the core functionality of the home feature.

Entities
--------

HomeUIConstantVariable
^^^^^^^^^^^^^^^^^^^^^^

UI constants entity (``lib/app/features/home/domain/entities/home_ui_constant_variable.dart``):

- Defines opacity values for enabled/disabled UI states:
  * ``_enableOpacity``: 1.0 for fully enabled elements
  * ``_disableOpacity``: 0.1 for disabled elements
  * ``_disableOpacityForReferenceValidation``: 0.3 for reference validation elements

- Specifies card height constants:
  * ``tmtTestButtonCardHeight``: 162 (pixels)
  * ``buttonCardMiddleHeight``: 80 (pixels)
  * ``buttonCardHeight``: 100 (pixels)
  * ``cardHorizontalPadding``: 24.0 (pixels)

- Provides utility methods:
  * ``getOpacityDependIsEnable``: Returns appropriate opacity based on enabled state
  * ``getOpacityDependIsEnableReferenceValidation``: Returns opacity for reference validation elements

- Defines UI elements:
  * ``cardCornerRadius``: 10.0 (pixels)
  * ``_lockIcon``: Icon configuration for disabled state
  * ``lockIconWidget``: Positioned lock widget for disabled elements

ReferenceValidationResult
^^^^^^^^^^^^^^^^^^^^^^^^^

Validation result entity (``lib/app/features/home/domain/entities/reference_validation_result_entity.dart``):

- Represents the outcome of reference code validation
- Contains properties:
  * ``isValid``: Whether the code passed validation rules
  * ``isUsedLocally``: Whether the code has been used in local database
  * ``isExists``: Whether the code exists in the system
  * ``errorMessage``: Optional error information

Repository Interfaces
---------------------

ReferenceValidationRepository
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Repository interface (``lib/app/features/home/domain/repository/reference_validation_repository.dart``):

- Defines contract for reference code validation operations:
  * ``isReferenceCodeUsedLocally``: Checks if reference code is used in local database
  * ``validateReferenceCodeRemotely``: Validates reference code with remote service

- Creates clear abstraction for dependency inversion
- Enables mocking for testing business logic

Use Cases
---------

ValidateReferenceCodeUseCase
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Validation use case (``lib/app/features/home/domain/usecases/validate_reference_code_use_case.dart``):

- Orchestrates reference code validation process:
  1. Checks if code has been used locally
  2. If not used locally, validates with remote service
  3. Processes validation results

- Handles various validation scenarios:
  * Local usage: Returns failure with appropriate status
  * Remote validation: Processes API response
  * Valid cases: Checks existence and returns appropriate status

- Implements business rules:
  * Validates message field from API response
  * Processes reference code existence information
  * Creates appropriate result entity with status data

The domain layer provides clear business logic for the Home module that is independent of UI implementation and external data sources. It serves as the stable core of the feature, allowing for flexible UI changes and data source modifications without disrupting the essential functionality.