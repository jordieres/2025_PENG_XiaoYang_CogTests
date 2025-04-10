part of app_mixins;

mixin NavigationMixin {
  void tmtTestToHelp(TmtHelpMode tmtHelpMode) {
    Get.toNamed(Routes.tmt_help, arguments: tmtHelpMode);
  }

  void navigateToPractice(TMTTestPracticeMode tmtTestPracticeMode) {
    Get.toNamed(Routes.tmt_practice, arguments: tmtTestPracticeMode);
  }

  void toRegisterUser() {
    Get.toNamed(Routes.register_user);
  }

  void toTmtTest() {
    Get.toNamed(Routes.tmt_test);
  }
}
