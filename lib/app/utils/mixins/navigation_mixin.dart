part of 'app_mixins.dart';

mixin NavigationMixin {
  void navigateAllToHome() {
    Get.offAllNamed(Routes.home);
  }

  void navigateToHome() {
    Get.offNamed(Routes.home);
  }

  void tmtTestToHelp(TmtHelpMode tmtHelpMode, [bool isCloseCurrent = false]) {
    if (isCloseCurrent) {
      Get.offNamed(Routes.tmt_help, arguments: tmtHelpMode);
    } else {
      Get.toNamed(Routes.tmt_help, arguments: tmtHelpMode);
    }
  }

  void navigateToPractice(TMTTestPracticeMode tmtTestPracticeMode) {
    Get.offNamed(Routes.tmt_practice, arguments: tmtTestPracticeMode);
  }

  void navigateToResultScreen(TmtGameInitData tmtGameInitData) {
    Get.offNamed(Routes.tmt_results, arguments: tmtGameInitData);
  }

  void toRegisterUser() {
    Get.toNamed(Routes.register_user);
  }

  void toUserTmtResultHistory() {
    Get.toNamed(Routes.tmt_user_history);
  }

  void toCurrentUserData() {
    Get.toNamed(Routes.current_user_data);
  }

  void toTmtTest(TmtType tmtType) {
    Get.offNamed(Routes.tmt_test, arguments: tmtType);
  }

  void toTmtHistory() {
    Get.toNamed(Routes.tmt_user_history);
  }
}

class ToSelectedPracticeOrTestArguments {
  static final referenceCode = 'referenceCode';
  static final handsUsed = 'handsUsed';
}
