part of app_mixins;

mixin NavigationMixin {

  void tmtTestToHelp(TmtTestStateFlow tmtTestStateFlow) {
    Get.toNamed(Routes.tmt_help,arguments: tmtTestStateFlow);
   }
}
