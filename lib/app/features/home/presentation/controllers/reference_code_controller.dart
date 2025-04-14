import 'package:get/get.dart';
import 'package:msdtmt/app/config/themes/AppColors.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../utils/ui/ui_utils.dart';
import '../../domain/usecases/validate_reference_code_use_case.dart';
import 'package:flutter/material.dart';

class ReferenceCodeController extends GetxController {
  final ValidateReferenceCodeUseCase validateReferenceCodeUseCase;

  ReferenceCodeController({required this.validateReferenceCodeUseCase});

  final RxBool isValidating = false.obs;
  final RxBool isValidated = false.obs;
  final RxString resultCode = ''.obs;
  final RxString errorMessage = ''.obs;
  final RxString fullReferenceCode = ''.obs;

  Future<void> validateReferenceCode(String code) async {
    if (code.isEmpty) {
      errorMessage.value = ReferenceCodeInputText.enterReferenceCode.tr;
      showErrorMessage(errorMessage.value);
      return;
    }

    isValidating.value = true;
    errorMessage.value = '';

    try {
      final result = await validateReferenceCodeUseCase.execute(code);

      if (result.isUsedLocally) {
        errorMessage.value = ReferenceCodeInputText.codeAlreadyUsed.tr;
        showErrorMessage(errorMessage.value);
        isValidated.value = false;
        return;
      }

      if (result.isValid) {
        fullReferenceCode.value = code;
        isValidated.value = true;
        showSuccessMessage(ReferenceCodeInputText.validReferenceCode.tr);
      } else {
        errorMessage.value =
            result.errorMessage ?? ReferenceCodeInputText.incorrectReference.tr;
        showErrorMessage(errorMessage.value);
        isValidated.value = false;
      }
    } catch (e) {
      errorMessage.value =
          '${ReferenceCodeInputText.validationError.tr}${e.toString()}';
      showErrorMessage(errorMessage.value);
      isValidated.value = false;
    } finally {
      isValidating.value = false;
    }
  }

  void resetValidation() {
    isValidated.value = false;
    resultCode.value = '';
    fullReferenceCode.value = '';
  }

  String getFullReferenceCode() {
    return fullReferenceCode.value;
  }

  void showErrorMessage(String message) {
    if (Get.context != null) {
      AppSnackbar.showCustomSnackbar(
        Get.context!,
        message,
        backgroundColor: AppColors.mainRed.withAlpha(240),
      );
    }
  }

  void showSuccessMessage(String message) {
    if (Get.context != null) {
      AppSnackbar.showCustomSnackbar(
        Get.context!,
        message,
        backgroundColor: Colors.green.withAlpha(240),
      );
    }
  }
}
