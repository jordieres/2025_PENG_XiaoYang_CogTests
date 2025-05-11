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
    /* if (await repository.isReferenceCodeUsedLocally(referenceCode)) {
      return ReferenceValidationResult(
        isValid: false,
        isUsedLocally: true,
        numberExists: 1,
        handsUsed: HandsUsed.NONE,
      );
    }*/ //TODO changed check numbers

    final resultData =
        await repository.validateReferenceCodeRemotely(referenceCode);

    if (!resultData.result) {
      return ReferenceValidationResult(
        isValid: false,
        isUsedLocally: false,
        numberExists: 0,
        errorMessage: resultData.errorMessage,
        handsUsed: HandsUsed.NONE,
      );
    }

    final messageValue = resultData.data[ApiConstants.messageField];
    final isValidMessage = StringHelper.equalsIgnoreCase(
        messageValue, ApiConstants.referenceCodeValid);

    if (!isValidMessage) {
      return ReferenceValidationResult(
        isValid: false,
        numberExists: 0,
        isUsedLocally: false,
        handsUsed: HandsUsed.NONE,
      );
    }

    final numberExists =
        resultData.data[ApiConstants.referenceCodeNumberExists];

    final handUsed = resultData.data[ApiConstants.referenceCodeHandsUsed];
    final HandsUsed handsUsed = HandsUsed.fromList(handUsed);

    int numberExistsInt = 0;
    if (numberExists != null) {
      if (numberExists is int) {
        numberExistsInt = numberExists;
      } else if (numberExists is String) {
        numberExistsInt = int.tryParse(numberExists) ?? 0;
      } else if (numberExists is bool) {
        numberExistsInt = numberExists ? 1 : 0;
      }
    }

    return ReferenceValidationResult(
      isValid: true,
      numberExists: numberExistsInt,
      isUsedLocally: false,
      handsUsed: handsUsed,
    );
  }
}
