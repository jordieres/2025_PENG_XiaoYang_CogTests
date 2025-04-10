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

  //--------------------------------------------TMT Select Hand Dialog Text------------------------------------------------------
  @override
  String get tmtSelectHandDialogTitle => "选择您要使用的手";

  @override
  String get tmtSelectHandDialogContent => "使用您感觉最舒适的手进行测试。这将优化您的TMT测试体验。";

  @override
  String get tmtSelectHandDialogRightHandButtonText => "右手";

  @override
  String get tmtSelectHandDialogLeftHandButtonText => "左手";

  //--------------------------------------------Select Mode Practice Or Test Screen Text------------------------------------------------------
  @override
  String get selectModePracticeOrTestTitle => "选择模式";

  @override
  String get selectModePracticeOrTestQuestionText => "您喜欢哪种模式？";

  @override
  String get selectModePracticeOrTestPracticeButtonText => "练习";

  @override
  String get selectModePracticeOrTestTestButtonText => "正式测试";

  @override
  String get selectModePracticeOrTestPracticeModeTitle => "练习模式";

  @override
  String get selectModePracticeOrTestPracticeModeContent =>
      "在此模式下，您可以练习测试而不会记录正式结果。这是您熟悉流程并在无压力的情况下纠正错误的理想方式。";

  @override
  String get selectModePracticeOrTestTestModeTitle => "正式测试";

  @override
  String get selectModePracticeOrTestTestModeContent =>
      "选择此模式开始评估测试。系统将记录您的时间和错误以计算分数。请确保您已准备就绪，因为此测试被视为最终测试。";

  @override
  String get selectModePracticeOrTestButtonUnderstood => "明白了";

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

  //--------------------------------------------Register User Screen Text------------------------------------------------------
  @override
  String get registerUserTitle => "我的资料";

  @override
  String get registerUserNicknameLabel => "昵称";

  @override
  String get registerUserNicknameHint => "输入昵称";

  @override
  String get registerUserNicknameError => "请输入昵称";

  @override
  String get registerUserNicknameExistsError => "该昵称已被使用";

  @override
  String get registerUserSexLabel => "性别";

  @override
  String get registerUserSexMale => "男";

  @override
  String get registerUserSexFemale => "女";

  @override
  String get registerUserSexError => "请选择性别";

  @override
  String get registerUserBirthDateLabel => "出生日期";

  @override
  String get registerUserBirthDateHint => "选择日期";

  @override
  String get registerUserBirthDateError => "请选择日期";

  @override
  String get registerUserBirthDatePickerTitle => "选择出生日期";

  @override
  String get registerUserBirthDatePickerCancel => "取消";

  @override
  String get registerUserBirthDatePickerConfirm => "确认";

  @override
  String get registerUserEducationLabel => "教育水平";

  @override
  String get registerUserEducationHint => "选择教育水平";

  @override
  String get registerUserEducationError => "请选择教育水平";

  @override
  String get registerUserEducationPrimary => "小学教育";

  @override
  String get registerUserEducationSecondary => "中学教育";

  @override
  String get registerUserEducationGraduate => "大学本科";

  @override
  String get registerUserEducationMaster => "硕士";

  @override
  String get registerUserEducationDoctorate => "博士";

  @override
  String get registerUserSaveButton => "保存";

  @override
  String get registerUserCancelButton => "取消";

  @override
  String get registerUserFormError => "请填写所有标记的字段。";

  @override
  String get registerUserSaveSuccess => "用户注册成功";

  @override
  String get registerUserSaveError => "保存用户时出错。请重试。";
}

final zh = ChineseMessages();
