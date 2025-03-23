part of 'app_translations.dart';

class TMTGame {
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

class TMTGamePractices {
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

  Map<String, String> get messages => {
        TMTGame.tmtGameCircleBegin: tmtGameCircleBegin,
        TMTGame.tmtGameCircleEnd: tmtGameCircleEnd,
        TMTGame.tmtGamePartACompletedTitle: tmtGamePartACompletedTitle,
        TMTGame.tmtGamePartACompletedBody: tmtGamePartACompletedBody,
        TMTGame.tmtGamePartBCompletedConfirmationButton:
            tmtGamePartBCompletedConfirmationButton,
        TMTGame.tmtGameTmtScreenAppBarTime: tmtGameTmtScreenAppBarTime,
        TMTGame.tmtGameTmtHelpTmtATitle: tmtGameTmtHelpTmtATitle,
        TMTGame.tmtGameTmtHelpTmtBTitle: tmtGameTmtHelpTmtBTitle,
        TMTGame.tmtGameTmtHelpTmtPrimaryButtonText:
            tmtGameTmtHelpTmtPrimaryButtonText,
        TMTGame.tmtGameTmtHelpTmtSecondaryButtonText:
            tmtGameTmtHelpTmtSecondaryButtonText,
        //--------------------------------------------TMT Practice Text------------------------------------------------------
        TMTGamePractices.tmtGamePracticeTmtAThenBDialogTitle:
            tmtGamePracticeTmtAThenBDialogTitle,
        TMTGamePractices.tmtGamePracticeTmtAThenBDialogCancelButtonText:
            tmtGamePracticeTmtAThenBDialogCancelButtonText,
        TMTGamePractices.tmtGamePracticeTmtAThenBDialogPrimaryButtonText:
            tmtGamePracticeTmtAThenBDialogPrimaryButtonText,
        TMTGamePractices.tmtGamePracticeOnlyTmtAOrTmtBDialogTitle:
            tmtGamePracticeOnlyTmtAOrTmtBDialogTitle,
        TMTGamePractices.tmtGamePracticeOnlyTmtAOrTmtBDialogCancelButtonText:
            tmtGamePracticeOnlyTmtAOrTmtBDialogCancelButtonText,
        TMTGamePractices.tmtGamePracticeOnlyTmtAOrTmtBDialogPrimaryButtonText:
            tmtGamePracticeOnlyTmtAOrTmtBDialogPrimaryButtonText,
        TMTGamePractices.tmtGamePracticeTmtAPageTitle:
            tmtGamePracticeTmtAPageTitle,
        TMTGamePractices.tmtGamePracticeTmtBPageTitle:
            tmtGamePracticeTmtBPageTitle,
      };
}
