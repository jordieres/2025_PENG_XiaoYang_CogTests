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
  String get tmtGameTmtHelpTmtADescription =>
      "将显示包含数字的圆圈。请用手指连接按升序排列的圆圈，从最低的数字开始，然后按顺序继续。 从1开始，然后是2，然后是3，依此类推。 尽可能快地准确响应。";

  @override
  String get tmtGameTmtHelpTmtBTitle => "TMT B 帮助";

  @override
  String get tmtGameTmtHelpTmtBDescription =>
      "将显示包含数字和字母的圆圈。请用手指连接按升序/字母顺序交替的数字和字母的圆圈。 从数字1开始，然后是字母A。 然后是数字2，然后是字母B。 尽可能快地准确响应。";

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

  //--------------------------------------------TMT Result Screen Text------------------------------------------------------
  @override
  String get tmtResultScreenTitle => "结果:";

  @override
  String get tmtResultScreenSessionText => "会话次数";

  @override
  String get tmtResultScreenTmtATitle => "TMT A";

  @override
  String get tmtResultScreenTmtBTitle => "TMT B";

  @override
  String get tmtResultScreenDurationLabel => "时长";

  @override
  String get tmtResultScreenErrorsLabel => "错误";

  @override
  String get tmtResultScreenThanksMessage => "感谢您的信任、时间和努力完成这个dTMT测试";

  @override
  String get tmtResultScreenFinishButton => "完成";

  @override
  String get tmtResultScreenLoadingResults => "加载结果...";

  @override
  String get tmtResultScreenSecondsUnit => "秒";

  @override
  String get tmtResultScreenErrorMessage => "发送结果时出错";
}

final zh = ChineseMessages();
