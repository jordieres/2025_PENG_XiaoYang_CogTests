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
  String get tmtGameTmtHelpTmtATitle => "说明：TMT A 部分";

  @override
  String get tmtGameTmtHelpTmtADescription =>
      "将显示包含数字的圆圈。请用手指连接按升序排列的圆圈，从最低的数字开始，然后按顺序继续。 "
          "\n\n• 从1开始，然后是2，然后是3，依此类推。( 1 → 2 → 3 → ...) "
          "\n\n• 尽可能快地准确响应。";

  @override
  String get tmtGameTmtHelpTmtBTitle => "说明：TMT B 部分";

  @override
  String get tmtGameTmtHelpTmtBDescription =>
      "将显示包含数字和字母的圆圈。请用手指连接按升序/字母顺序交替的数字和字母的圆圈。 "
          "\n\n• 从数字1开始，然后是字母A。 然后是数字2，然后是字母B。(1 → A → 2 → B → ...) "
          "\n\n• 尽可能快地准确响应。";

  @override
  String get tmtGameTmtHelpTmtSecondaryButtonText => "开始正式的测试";

  @override
  String get tmtGameCountdownMessage => "准备好！测试将在以下时间开始...";

  @override
  String get tmtGameTmtHelpGeneralTitle => "欢迎参加dTMT测试";

  @override
  String get tmtGameTmtHelpGeneralDescription =>
      "欢迎参加dTMT测试。此测试由两部分组成（A部分和B部分）。每部分将以简短的培训阶段开始，以熟悉任务，然后立即进行相应的计时测试。\n\n重要提示：\n\n• 每个培训阶段（练习A和练习B）只会执行一次。\n\n• 一旦完成练习A，您将直接进入测试A，该测试无法重复。\n\n• 同样，当您完成练习B时，您将直接进入测试B，该测试也无法重复。\n\n• 这确保了结果的有效性，并避免了测试中重复学习的效果。";

  @override
  String get tmtGameTmtHelpGeneralButtonText => "开始";

  @override
  String get tmtGameTmtHelpTmtAButtonText => "开始 A 部分练习";

  @override
  String get tmtGameTmtHelpTmtBButtonText => "开始 B 部分练习";

  @override
  String get tmtGameTmtHelpTmtAButtonBackTest => "返回";

  //--------------------------------------------Home Header Text------------------------------------------------------
  @override
  String get homeHeaderSelectThemeTitle => "选择主题";

  @override
  String get homeHeaderLightModeOption => "浅色模式";

  @override
  String get homeHeaderDarkModeOption => "深色模式";

  @override
  String get homeHeaderSystemThemeOption => "系统主题";

  @override
  String get languageNameEnglish => "EN";

  @override
  String get languageNameSpanish => "ES";

  @override
  String get languageNameChinese => "中文";

  //--------------------------------------------TMT Practice Text------------------------------------------------------
  @override
  String get tmtGamePracticeTmtAPageTitle => "TMT A 练习";

  @override
  String get tmtGamePracticeTmtBPageTitle => "TMT B 练习";

  @override
  String get tmtGamePracticeCompletedADialogTitle => "练习 A 部分完成！";

  @override
  String get tmtGamePracticeCompletedADialogContent =>
      "您已完成 A 部分的训练。现在您将开始测试 A。请记住，此部分是计时的，不能重复。";

  @override
  String get tmtGamePracticeCompletedADialogButtonText => "开始测试 A";

  @override
  String get tmtGamePracticeCompletedBDialogTitle => "练习 B 部分完成！";

  @override
  String get tmtGamePracticeCompletedBDialogContent =>
      "您已完成 B 部分的训练。现在您将开始测试 B。请记住，此部分是计时的，不能重复。";

  @override
  String get tmtGamePracticeCompletedBDialogButtonText => "开始测试 B";

  //--------------------------------------------TMT Select Hand Dialog Text------------------------------------------------------
  @override
  String get tmtSelectHandDialogFirstTimeTitle => "选择 TMT 测试用手";

  @override
  String get tmtSelectHandDialogFirstTimeContent =>
      "请选择您本次 TMT 测试希望使用的手。后续测试可能需要您交替使用双手以确保评估的全面性。";

  @override
  String get tmtSelectHandDialogLeftHandButtonText => "左手";

  @override
  String get tmtSelectHandDialogRightHandButtonText => "右手";

  @override
  String get tmtSelectHandDialogRightHandOnlyTitle => "TMT 测试：请使用右手";

  @override
  String get tmtSelectHandDialogRightHandOnlyContent =>
      "您上次 TMT 测试使用了左手。根据测试要求，为确保结果的有效性，本次测试请使用右手。";

  @override
  String get tmtSelectHandDialogUseRightHandButton => "使用右手开始测试";

  @override
  String get tmtSelectHandDialogLeftHandOnlyTitle => "TMT 测试：请使用左手";

  @override
  String get tmtSelectHandDialogLeftHandOnlyContent =>
      "您上次 TMT 测试使用了右手。根据测试要求，为确保结果的有效性，本次测试请使用左手。";

  @override
  String get tmtSelectHandDialogUseLeftHandButton => "使用左手开始测试";

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
  String get registerUserTitle => "创建新账户";

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

  //--------------------------------------------Current User Data Screen Text------------------------------------------------------
  @override
  String get currentUserDataScreenTitle => "用户资料";

  @override
  String get currentUserDataScreenNoUserFound => "未找到用户资料";

  @override
  String get currentUserDataScreenCreateProfile => "创建资料";

  @override
  String get currentUserDataScreenDeleteProfile => "删除资料";

  @override
  String get currentUserDataScreenBackButton => "返回";

  @override
  String get currentUserDataScreenConfirmDeleteTitle => "确认删除";

  @override
  String get currentUserDataScreenConfirmDeleteContent =>
      "您确定要删除此用户资料吗？此操作无法撤消。";

  @override
  String get currentUserDataScreenConfirmDeleteButton => "删除";

  @override
  String get currentUserDataScreenCancelButton => "取消";

  @override
  String get currentUserDataScreenDeleteSuccess => "用户资料已成功删除";

  @override
  String get currentUserDataScreenDeleteError => "删除用户资料时出错";

  //--------------------------------------------User Result History Screen Text------------------------------------------------------
  @override
  String get userResultHistoryScreenTitle => "我的测试";

  @override
  String get userResultHistoryScreenNoData => "没有可用结果";

  @override
  String get userResultHistoryScreenDateHeader => "日期";

  @override
  String get userResultHistoryScreenReferenceHeader => "编号";

  @override
  String get userResultHistoryScreenTmtAHeader => "TMT-A";

  @override
  String get userResultHistoryScreenTmtBHeader => "TMT-B";

  @override
  String get userResultHistoryScreenSecondsUnit => "秒";

  @override
  String get userResultHistoryScreenHandUsedHeader => "使用的手";

  @override
  String get userResultHistoryScreenRightHand => "右手";

  @override
  String get userResultHistoryScreenLeftHand => "左手";

//--------------------------------------------Reference Code Input Text------------------------------------------------------
  @override
  String get referenceCodeInputLabel => "参考编号";

  @override
  String get referenceCodeInputBothFieldsRequired => "请填写两个字段";

  @override
  String get referenceCodeInputEnterReferenceCode => "请输入参考编号";

  @override
  String get referenceCodeInputCodeAlreadyUsed => "该参考编号已被使用";

  @override
  String get referenceCodeInputValidReferenceCode => "有效的参考编号";

  @override
  String get referenceCodeInputIncorrectReference => "参考编号不正确，请核实或联系您的神经科医生";

  @override
  String get referenceCodeInputValidationError => "验证编号时出错: ";

  //--------------------------------------------Select User Profile Dialog Text------------------------------------------------------
  @override
  String get selectUserProfileDialogTitle => "选择用户";

  @override
  String get selectUserProfileDialogNoProfiles => "没有可用的用户";

  @override
  String get selectUserProfileDialogCancelButton => "取消";

  @override
  String get selectUserProfileDialogDeleteConfirmTitle => "删除用户";

  @override
  String get selectUserProfileDialogDeleteConfirmContent =>
      "您确定要删除\"{user}\"吗？";

  @override
  String get selectUserProfileDialogDeleteButton => "删除";

  @override
  String get selectUserProfileDialogCancelDeleteButton => "取消";

  @override
  String get selectUserProfileDialogProfileDeletedSuccess => "用户已删除:";

  @override
  String get selectUserProfileDialogProfileDeletedError => "删除用户时出错";

  @override
  String get selectUserProfileDialogProfileSelectedSuccess => "已选择用户";

  @override
  String get selectUserProfileDialogProfileSelectedError => "设置用户时出错";

  @override
  String get selectUserProfileDialogSearchAnchorSearchBarHint => "搜索用户资料";

  @override
  String get selectUserProfileDialogSearchAnchorSearchBarNotFound =>
      '没有符合您搜索条件的用户资料';

  //--------------------------------------------Select User Dropdown Text------------------------------------------------------
  @override
  String get selectUserDropdownCreateUser => "创建用户";

  @override
  String get selectUserDropdownGreeting => "你好, ";

  //--------------------------------------------Tmt Test Button Card Text------------------------------------------------------
  @override
  String get tmtTestButtonCardStartTest => "开始\nTMT测试";

  @override
  String get tmtTestButtonCardNumberOfCircles => "圆圈数量";

  @override
  String get tmtTestButtonCardDialogTitle => "圆圈数量";

  @override
  String get tmtTestButtonCardChooseBetween => "选择以下选项:";

  @override
  String get tmtTestButtonCardCompleteTest => "25个圆圈: 完整测试。";

  @override
  String get tmtTestButtonCardSimplifiedVersion => "15个圆圈: 小屏幕简化版本。";

  @override
  String get tmtTestButtonCardConsultNeurologist => "了解更多的详情，请咨询您的神经科医生。";

  @override
  String get tmtTestButtonCardUnderstood => "明白了";

  @override
  String get tmtTestButtonCardCancel => "取消";

  //--------------------------------------------Home Card Button Text------------------------------------------------------
  @override
  String get homeCardButtonVisualizeMyData => "查看我的资料";

  @override
  String get homeCardButtonViewMyHistory => "查看我的测试";

  @override
  String get homeCardButtonCreateNewProfile => "创建新用户";
}

final zh = ChineseMessages();
