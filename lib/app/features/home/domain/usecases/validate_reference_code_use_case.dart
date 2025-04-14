import '../entities/reference_validation_result_entity.dart';
import '../repository/reference_validation_repository.dart';

class ValidateReferenceCodeUseCase {
  final ReferenceValidationRepository repository;

  ValidateReferenceCodeUseCase({
    required this.repository,
  });

  Future<ReferenceValidationResult> execute(String referenceCode) async {
    final isUsedLocally =
        await repository.isReferenceCodeUsedLocally(referenceCode);

    if (isUsedLocally) {
      return ReferenceValidationResult(
        isValid: false,
        isUsedLocally: true,
      );
    }

    final resultData =
        await repository.validateReferenceCodeRemotely(referenceCode);

    if (resultData.result) { //TODO valid with message
      return ReferenceValidationResult(isValid: true, isUsedLocally: false);
    } else {
      return ReferenceValidationResult(
        isValid: false,
        isUsedLocally: false,
        errorMessage: resultData.errorMessage,
      );
    }
  }
}
