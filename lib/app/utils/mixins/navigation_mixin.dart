part of app_mixins;

mixin NavigationMixin {
  void navigateAllToHome() {
    Get.offAllNamed(Routes.home);
  }

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

  void toUserTmtResultHistory() {
    Get.toNamed(Routes.tmt_user_history);
  }

  void toCurrentUserData() {
    Get.toNamed(Routes.current_user_data);
  }

  void toSelectedPracticeOrTest(String tmtReferenceCode) {
    Get.toNamed(Routes.tmt_select_practice_or_test,
        arguments: tmtReferenceCode);
  }

  void toTmtTest(TmtGameInitData tmtGameInitData) {
    Get.toNamed(Routes.tmt_test, arguments: tmtGameInitData);
  }

  void toTmtHistory() {
    Get.toNamed(Routes.tmt_user_history);
  }
}
