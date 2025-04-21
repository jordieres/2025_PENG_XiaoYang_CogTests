import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_dialog.dart';
import '../../domain/entities/result/tmt_game_hand_used.dart';

Future<TmtGameHandUsed> showTmtSelectHandDialogGetX() async {
  final result = await Get.dialog<TmtGameHandUsed>(
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
      dismissibleByBackButton: false,
    ),
    barrierDismissible: false,
  );
  return result ?? TmtGameHandUsed.RIGHT;
}
