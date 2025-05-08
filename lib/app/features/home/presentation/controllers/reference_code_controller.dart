import 'package:get/get.dart';
import 'package:msdtmt/app/config/themes/AppColors.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../utils/ui/ui_utils.dart';
import '../../domain/entities/reference_validation_result_entity.dart';
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
  final Rx<HandsUsed> handsUsed = HandsUsed.NONE.obs;

  Future<void> validateReferenceCode(String mainCode, String suffixCode) async {
    isValidating.value = true;
    isValidated.value = false;
    errorMessage.value = '';

    if (mainCode.isEmpty || suffixCode.isEmpty) {
      errorMessage.value = ReferenceCodeInputText.enterReferenceCode.tr;
      showErrorMessage(errorMessage.value);
      isValidating.value = false;
      return;
    }

    String code = '${mainCode.trim()}-${suffixCode.trim()}';

    try {
      final result = await validateReferenceCodeUseCase.execute(code);

      if (result.isUsedLocally) {
        errorMessage.value = ReferenceCodeInputText.codeAlreadyUsed.tr;
      } else if (!result.isValid) {
        errorMessage.value =
            result.errorMessage ?? ReferenceCodeInputText.incorrectReference.tr;
      } else if (result.canUse()) {
        errorMessage.value = ReferenceCodeInputText.codeAlreadyUsed.tr;
      } else {
        fullReferenceCode.value = code;
        handsUsed.value = result.handsUsed;
        isValidated.value = true;
        showSuccessMessage(ReferenceCodeInputText.validReferenceCode.tr);
      }

      if (!isValidated.value && errorMessage.isNotEmpty) {
        showErrorMessage(errorMessage.value);
      }
    } catch (e) {
      errorMessage.value =
          '${ReferenceCodeInputText.validationError.tr}${e.toString()}';
      showErrorMessage(errorMessage.value);
    } finally {
      isValidating.value = false;
    }
  }

  void resetValidation() {
    isValidated.value = false;
    resultCode.value = '';
    fullReferenceCode.value = '';
    handsUsed.value = HandsUsed.NONE;
  }

  String getFullReferenceCode() {
    return fullReferenceCode.value;
  }

  HandsUsed getHandsUsed() {
    return handsUsed.value;
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
