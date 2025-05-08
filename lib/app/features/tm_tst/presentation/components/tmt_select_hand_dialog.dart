import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_dialog.dart';
import '../../../home/domain/entities/reference_validation_result_entity.dart';
import '../../domain/entities/result/tmt_game_hand_used.dart';

Future<TmtGameHandUsed?> showTmtSelectHandDialogGetX(
    HandsUsed usedHands) async {
  final bool leftHandUsed =
      usedHands == HandsUsed.LEFT || usedHands == HandsUsed.BOTH;
  final bool rightHandUsed =
      usedHands == HandsUsed.RIGHT || usedHands == HandsUsed.BOTH;

  if (leftHandUsed) {
    return await showOnlyRightHandDialog();
  } else if (rightHandUsed) {
    return await showOnlyLeftHandDialog();
  } else {
    return await showBothHandsDialog();
  }
}

Future<TmtGameHandUsed?> showOnlyRightHandDialog() async {
  return await Get.dialog<TmtGameHandUsed>(
    CustomDialog(
      title: TmtSelectHandDialogText.title.tr,
      content: Text(
        "La mano izquierda ya ha sido utilizada. Por favor usa tu mano derecha para este test.",
        textAlign: TextAlign.center,
      ),
      mode: DialogMode.singleButton,
      primaryButtonText:
          "${TmtSelectHandDialogText.rightHandButtonText.tr} \u{1F449}",
      onPrimaryPressed: () {
        Get.back(result: TmtGameHandUsed.RIGHT);
      },
      dismissibleByBackButton: true,
    ),
    barrierDismissible: true,
  );
}

Future<TmtGameHandUsed?> showOnlyLeftHandDialog() async {
  return await Get.dialog<TmtGameHandUsed>(
    CustomDialog(
      title: TmtSelectHandDialogText.title.tr,
      content: Text(
        "La mano derecha ya ha sido utilizada. Por favor usa tu mano izquierda para este test.",
        textAlign: TextAlign.center,
      ),
      mode: DialogMode.singleButton,
      primaryButtonText:
          "\u{1F448} ${TmtSelectHandDialogText.leftHandButtonText.tr}",
      onPrimaryPressed: () {
        Get.back(result: TmtGameHandUsed.LEFT);
      },
      dismissibleByBackButton: true,
    ),
    barrierDismissible: true,
  );
}

Future<TmtGameHandUsed?> showBothHandsDialog() async {
  return await Get.dialog<TmtGameHandUsed>(
    CustomDialog(
      title: TmtSelectHandDialogText.title.tr,
      content: Text(
        TmtSelectHandDialogText.content.tr,
        textAlign: TextAlign.center,
      ),
      mode: DialogMode.twoMainButtons,
      primaryButtonText:
          "${TmtSelectHandDialogText.rightHandButtonText.tr} \u{1F449}",
      onPrimaryPressed: () {
        Get.back(result: TmtGameHandUsed.RIGHT);
      },
      onLeftPrimaryButtonText:
          "\u{1F448} ${TmtSelectHandDialogText.leftHandButtonText.tr}",
      onLeftPrimaryPressed: () {
        Get.back(result: TmtGameHandUsed.LEFT);
      },
      dismissibleByBackButton: true,
    ),
    barrierDismissible: true,
  );
}
