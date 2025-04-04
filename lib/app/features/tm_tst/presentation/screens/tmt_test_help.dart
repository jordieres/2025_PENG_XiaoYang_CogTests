import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/screens/tmt_test_practice_screen.dart';

import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../shared_components/custom_secondary_button.dart';
import '../../../../utils/helpers/app_helpers.dart';
import '../../../../utils/mixins/app_mixins.dart';

enum TmtHelpMode { TMT_TEST_A, TMT_TEST_B, TMT_PRACTICE_A, TMT_PRACTICE_B }

class TmtTestHelpPage extends StatelessWidget with NavigationMixin {
  const TmtTestHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TmtHelpMode tmtHelpMode;
    try {
      tmtHelpMode = Get.arguments as TmtHelpMode;
    } catch (e) {
      tmtHelpMode = TmtHelpMode.TMT_TEST_A;
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: _getHelpTitle(tmtHelpMode),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content area with vertically centered text
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            _getHelpDescription(tmtHelpMode),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Fixed buttons at bottom
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPrimaryButton(
                    text: TMTGameText.tmtGameTmtHelpTmtPrimaryButtonText.tr,
                    onPressed: () {
                      _toPracticePage(tmtHelpMode);
                    },
                  ),
                  SizedBox(height: DeviceHelper.isTablet ? 28 : 22),
                  CustomSecondaryButton(
                    text: TMTGameText.tmtGameTmtHelpTmtSecondaryButtonText.tr,
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

  String _getHelpTitle(TmtHelpMode tmtHelpMode) {
    switch (tmtHelpMode) {
      case TmtHelpMode.TMT_TEST_A:
      case TmtHelpMode.TMT_PRACTICE_A:
        return TMTGameText.tmtGameTmtHelpTmtATitle.tr;
      case TmtHelpMode.TMT_TEST_B:
      case TmtHelpMode.TMT_PRACTICE_B:
        return TMTGameText.tmtGameTmtHelpTmtBTitle.tr;
    }
  }

  String _getHelpDescription(TmtHelpMode tmtHelpMode) {
    switch (tmtHelpMode) {
      case TmtHelpMode.TMT_TEST_A:
      case TmtHelpMode.TMT_PRACTICE_A:
        return TMTGameText.tmtGameTmtHelpTmtADescription.tr;
      case TmtHelpMode.TMT_TEST_B:
      case TmtHelpMode.TMT_PRACTICE_B:
        return TMTGameText.tmtGameTmtHelpTmtBDescription.tr;
    }
  }

  void _toPracticePage(TmtHelpMode tmtHelpMode) {
    TMTTestPracticeMode practiceMode = TMTTestPracticeMode.TMT_A_ONLY;
    switch (tmtHelpMode) {
      case TmtHelpMode.TMT_TEST_A:
        practiceMode = TMTTestPracticeMode.TMT_A_ONLY;
        break;
      case TmtHelpMode.TMT_TEST_B:
      case TmtHelpMode.TMT_PRACTICE_B:
        practiceMode = TMTTestPracticeMode.TMT_B_ONLY;
        break;
      case TmtHelpMode.TMT_PRACTICE_A:
        practiceMode = TMTTestPracticeMode.TMT_A_THEN_B;
        break;
    }
    navigateToPractice(practiceMode);
  }
}