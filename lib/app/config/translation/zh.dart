part of 'app_translations.dart';

class ChineseMessages extends BaseMessages {
  @override
  String get tmtGameCircleBegin => "起点";

  @override
  String get tmtGameCircleEnd => "终点";

  @override
  String get tmtGamePartACompletedTitle => "TMT A部分完成";

  @override
  String get tmtGamePartACompletedBody => "您已成功完成TMT A部分。准备好开始TMT B部分了吗？";

  @override
  String get tmtGamePartBCompletedConfirmationButton => "是的，开始TMT B部分";

  @override
  String get tmtGameTmtScreenAppBarTime => "时间: ";

  @override
  String get tmtGameTmtHelpTmtATitle => "TMT A 帮助";

  @override
  String get tmtGameTmtHelpTmtBTitle => "TMT B 帮助";

  @override
  String get tmtGameTmtHelpTmtPrimaryButtonText => "我想要练习";

  @override
  String get tmtGameTmtHelpTmtSecondaryButtonText => "开始正式的测试";

  //--------------------------------------------TMT Practice Text------------------------------------------------------
  @override
  String get tmtGamePracticeTmtAThenBDialogTitle => "重复这个TMT A练习还是继续下一个挑战？";

  @override
  String get tmtGamePracticeTmtAThenBDialogCancelButtonText => "继续";

  @override
  String get tmtGamePracticeTmtAThenBDialogPrimaryButtonText => "重复";

  @override
  String get tmtGamePracticeOnlyTmtAOrTmtBDialogTitle => "你准备好开始TMT测试了吗？";

  @override
  String get tmtGamePracticeOnlyTmtAOrTmtBDialogCancelButtonText => "是的，开始";

  @override
  String get tmtGamePracticeOnlyTmtAOrTmtBDialogPrimaryButtonText => "不，我需要重复";

  @override
  String get tmtGamePracticeTmtAPageTitle => "TMT A 练习";

  @override
  String get tmtGamePracticeTmtBPageTitle => "TMT B 练习";
}

final zh = ChineseMessages();
