part of 'app_translations.dart';

class TMTGameText {
  static String tmtGameCircleBegin = 'tmt_game_circle_begin';
  static String tmtGameCircleEnd = 'tmt_game_circle_end';
  static String tmtGamePartACompletedTitle = 'tmt_game_part_a_completed_title';
  static String tmtGamePartACompletedBody = 'tmt_game_part_a_completed_body';
  static String tmtGamePartBCompletedConfirmationButton =
      'tmt_game_part_b_completed_confirmation_button';
  static String tmtGameTmtScreenAppBarTime = 'tmt_game_tmt_screen_app_bar_time';
  static String tmtGameTmtHelpTmtATitle = 'tmt_game_tmt_help_tmt_a_title';
  static String tmtGameTmtHelpTmtBTitle = 'tmt_game_tmt_help_tmt_b_title';
  static String tmtGameTmtHelpTmtPrimaryButtonText =
      'tmt_game_tmt_help_tmt_primary_button_text';
  static String tmtGameTmtHelpTmtSecondaryButtonText =
      'tmt_game_tmt_help_tmt_secondary_button_text';
}

class TMTGamePracticesText {
  static String tmtGamePracticeTmtAThenBDialogTitle =
      'tmt_game_practice_tmt_a_then_b_dialog_title';
  static String tmtGamePracticeTmtAThenBDialogCancelButtonText =
      'tmt_game_practice_tmt_a_then_b_dialog_cancel_button_text';
  static String tmtGamePracticeTmtAThenBDialogPrimaryButtonText =
      'tmt_game_practice_tmt_a_then_b_dialog_primary_button_text';
  static String tmtGamePracticeOnlyTmtAOrTmtBDialogTitle =
      'tmt_game_practice_only_tmt_a_or_tmt_b_dialog_title';
  static String tmtGamePracticeOnlyTmtAOrTmtBDialogCancelButtonText =
      'tmt_game_practice_only_tmt_a_or_tmt_b_dialog_cancel_button_text';
  static String tmtGamePracticeOnlyTmtAOrTmtBDialogPrimaryButtonText =
      'tmt_game_practice_only_tmt_a_or_tmt_b_dialog_primary_button_text';

  static String tmtGamePracticeTmtAPageTitle =
      'tmt_game_practice_tmt_a_page_title';
  static String tmtGamePracticeTmtBPageTitle =
      'tmt_game_practice_tmt_b_page_title';
}

// New class for TMT Result Screen translations
class TMTResultScreen {
  static String title = 'tmt_result_screen_title';
  static String sessionText = 'tmt_result_screen_session_text';
  static String tmtATitle = 'tmt_result_screen_tmt_a_title';
  static String tmtBTitle = 'tmt_result_screen_tmt_b_title';
  static String durationLabel = 'tmt_result_screen_duration_label';
  static String errorsLabel = 'tmt_result_screen_errors_label';
  static String thanksMessage = 'tmt_result_screen_thanks_message';
  static String finishButton = 'tmt_result_screen_finish_button';
  static String loadingResults = 'tmt_result_screen_loading_results';
  static String secondsUnit = 'tmt_result_screen_seconds_unit';
}

abstract class BaseMessages {
  String get tmtGameCircleBegin;

  String get tmtGameCircleEnd;

  String get tmtGamePartACompletedTitle;

  String get tmtGamePartACompletedBody;

  String get tmtGamePartBCompletedConfirmationButton;

  String get tmtGameTmtScreenAppBarTime;

  String get tmtGameTmtHelpTmtATitle;

  String get tmtGameTmtHelpTmtBTitle;

  String get tmtGameTmtHelpTmtPrimaryButtonText;

  String get tmtGameTmtHelpTmtSecondaryButtonText;

  //--------------------------------------------TMT Practice Text------------------------------------------------------

  String get tmtGamePracticeTmtAThenBDialogTitle;

  String get tmtGamePracticeTmtAThenBDialogCancelButtonText;

  String get tmtGamePracticeTmtAThenBDialogPrimaryButtonText;

  String get tmtGamePracticeOnlyTmtAOrTmtBDialogTitle;

  String get tmtGamePracticeOnlyTmtAOrTmtBDialogCancelButtonText;

  String get tmtGamePracticeOnlyTmtAOrTmtBDialogPrimaryButtonText;

  String get tmtGamePracticeTmtAPageTitle;

  String get tmtGamePracticeTmtBPageTitle;

  //--------------------------------------------TMT Result Screen Text------------------------------------------------------

  String get tmtResultScreenTitle;

  String get tmtResultScreenSessionText;

  String get tmtResultScreenTmtATitle;

  String get tmtResultScreenTmtBTitle;

  String get tmtResultScreenDurationLabel;

  String get tmtResultScreenErrorsLabel;

  String get tmtResultScreenThanksMessage;

  String get tmtResultScreenFinishButton;

  String get tmtResultScreenLoadingResults;

  String get tmtResultScreenSecondsUnit;

  Map<String, String> get messages => {
    TMTGameText.tmtGameCircleBegin: tmtGameCircleBegin,
    TMTGameText.tmtGameCircleEnd: tmtGameCircleEnd,
    TMTGameText.tmtGamePartACompletedTitle: tmtGamePartACompletedTitle,
    TMTGameText.tmtGamePartACompletedBody: tmtGamePartACompletedBody,
    TMTGameText.tmtGamePartBCompletedConfirmationButton:
    tmtGamePartBCompletedConfirmationButton,
    TMTGameText.tmtGameTmtScreenAppBarTime: tmtGameTmtScreenAppBarTime,
    TMTGameText.tmtGameTmtHelpTmtATitle: tmtGameTmtHelpTmtATitle,
    TMTGameText.tmtGameTmtHelpTmtBTitle: tmtGameTmtHelpTmtBTitle,
    TMTGameText.tmtGameTmtHelpTmtPrimaryButtonText:
    tmtGameTmtHelpTmtPrimaryButtonText,
    TMTGameText.tmtGameTmtHelpTmtSecondaryButtonText:
    tmtGameTmtHelpTmtSecondaryButtonText,
    //--------------------------------------------TMT Practice Text------------------------------------------------------
    TMTGamePracticesText.tmtGamePracticeTmtAThenBDialogTitle:
    tmtGamePracticeTmtAThenBDialogTitle,
    TMTGamePracticesText.tmtGamePracticeTmtAThenBDialogCancelButtonText:
    tmtGamePracticeTmtAThenBDialogCancelButtonText,
    TMTGamePracticesText.tmtGamePracticeTmtAThenBDialogPrimaryButtonText:
    tmtGamePracticeTmtAThenBDialogPrimaryButtonText,
    TMTGamePracticesText.tmtGamePracticeOnlyTmtAOrTmtBDialogTitle:
    tmtGamePracticeOnlyTmtAOrTmtBDialogTitle,
    TMTGamePracticesText
        .tmtGamePracticeOnlyTmtAOrTmtBDialogCancelButtonText:
    tmtGamePracticeOnlyTmtAOrTmtBDialogCancelButtonText,
    TMTGamePracticesText
        .tmtGamePracticeOnlyTmtAOrTmtBDialogPrimaryButtonText:
    tmtGamePracticeOnlyTmtAOrTmtBDialogPrimaryButtonText,
    TMTGamePracticesText.tmtGamePracticeTmtAPageTitle:
    tmtGamePracticeTmtAPageTitle,
    TMTGamePracticesText.tmtGamePracticeTmtBPageTitle:
    tmtGamePracticeTmtBPageTitle,
    //--------------------------------------------TMT Result Screen Text------------------------------------------------------
    TMTResultScreen.title: tmtResultScreenTitle,
    TMTResultScreen.sessionText: tmtResultScreenSessionText,
    TMTResultScreen.tmtATitle: tmtResultScreenTmtATitle,
    TMTResultScreen.tmtBTitle: tmtResultScreenTmtBTitle,
    TMTResultScreen.durationLabel: tmtResultScreenDurationLabel,
    TMTResultScreen.errorsLabel: tmtResultScreenErrorsLabel,
    TMTResultScreen.thanksMessage: tmtResultScreenThanksMessage,
    TMTResultScreen.finishButton: tmtResultScreenFinishButton,
    TMTResultScreen.loadingResults: tmtResultScreenLoadingResults,
    TMTResultScreen.secondsUnit: tmtResultScreenSecondsUnit,
  };
}