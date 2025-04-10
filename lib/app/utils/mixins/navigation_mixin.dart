part of app_mixins;

mixin NavigationMixin {
  void navigateToHome() {
    Get.offNamed(Routes.home);
  }

  void tmtTestToHelp(TmtHelpMode tmtHelpMode) {
    Get.toNamed(Routes.tmt_help, arguments: tmtHelpMode);
  }

  void navigateToPractice(TMTTestPracticeMode tmtTestPracticeMode) {
    Get.toNamed(Routes.tmt_practice, arguments: tmtTestPracticeMode);
  }

  void navigateToResultScreen(TmtGameInitData tmtGameInitData) {
    Get.offNamed(Routes.tmt_results, arguments: tmtGameInitData);
  }

  void toRegisterUser() {
    Get.toNamed(Routes.register_user);
  }

  void toTmtTest(TmtGameInitData tmtGameInitData) {
    Get.toNamed(Routes.tmt_test, arguments: tmtGameInitData);
  }
}
