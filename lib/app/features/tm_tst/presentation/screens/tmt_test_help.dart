import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../shared_components/custom_secondary_button.dart';
import '../../../../utils/helpers/app_helpers.dart';
import '../controllers/tmt_test_flow_state_controller.dart';

class TmtTestHelpPage extends StatelessWidget {
  const TmtTestHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TmtTestStateFlow tmtTestStateFlow;
    try {
      tmtTestStateFlow = Get.arguments as TmtTestStateFlow;
    } catch (e) {
      tmtTestStateFlow = TmtTestStateFlow.TMT_A_IN_PROGRESS;
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: _getHelpTitle(tmtTestStateFlow),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Aquí se mostrará\nun video,\nanimación o texto\npara describir\nlas instrucciones\npara realizar\nel test TMT B",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: DeviceHelper.isTablet ? 46 : 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPrimaryButton(
                    text: TMTGame.tmtGameTmtHelpTmtPrimaryButtonText.tr,
                    onPressed: () {},
                  ),
                  SizedBox(height: DeviceHelper.isTablet ? 28 : 22),
                  CustomSecondaryButton(
                    text: TMTGame.tmtGameTmtHelpTmtSecondaryButtonText.tr,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getHelpTitle(TmtTestStateFlow tmtTestStateFlow) {
    switch (tmtTestStateFlow) {
      case TmtTestStateFlow.TMT_A_IN_PROGRESS:
        return TMTGame.tmtGameTmtHelpTmtATitle.tr;
      case TmtTestStateFlow.TMT_B_IN_PROGRESS:
        return TMTGame.tmtGameTmtHelpTmtBTitle.tr;
      default:
        return TMTGame.tmtGameTmtHelpTmtATitle.tr;
    }
  }
}
