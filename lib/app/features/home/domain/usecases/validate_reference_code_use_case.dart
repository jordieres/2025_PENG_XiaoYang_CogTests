import '../../../../utils/helpers/app_helpers.dart';
import '../../../../utils/services/net/rest_api_services.dart';
import '../entities/reference_validation_result_entity.dart';
import '../repository/reference_validation_repository.dart';

class ValidateReferenceCodeUseCase {
  final ReferenceValidationRepository repository;

  ValidateReferenceCodeUseCase({
    required this.repository,
  });

  Future<ReferenceValidationResult> execute(String referenceCode) async {
    if (await repository.isReferenceCodeUsedLocally(referenceCode)) {
      return ReferenceValidationResult(
        isValid: false,
        isUsedLocally: true,
        isExists: true,
      );
    }

    final resultData =
        await repository.validateReferenceCodeRemotely(referenceCode);

    if (!resultData.result) {
      return ReferenceValidationResult(
        isValid: false,
        isUsedLocally: false,
        isExists: true,
        errorMessage: resultData.errorMessage,
      );
    }

    final messageValue = resultData.data[ApiConstants.messageField];
    final isValidMessage = StringHelper.equalsIgnoreCase(
        messageValue, ApiConstants.referenceCodeValid);

    if (!isValidMessage) {
      return ReferenceValidationResult(
        isValid: false,
        isExists: true,
        isUsedLocally: false,
      );
    }

    final numberExists =
        resultData.data[ApiConstants.referenceCodeNumberExists];
    final bool isCodeExists = numberExists != null && numberExists > 0;

    return ReferenceValidationResult(
      isValid: true,
      isExists: isCodeExists,
      isUsedLocally: false,
    );
  }
}
