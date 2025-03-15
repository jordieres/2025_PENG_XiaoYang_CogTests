part of 'app_translations.dart';

class TMTGame {
  static String tmtGameCircleBegin = 'tmt_game_circle_begin';
  static String tmtGameCircleEnd = 'tmt_game_circle_end';
  static String tmtGamePartACompletedTitle = 'tmt_game_part_a_completed_title';
  static String tmtGamePartACompletedBody = 'tmt_game_part_a_completed_body';
  static String tmtGamePartBCompletedConfirmationButton =
      'tmt_game_part_b_completed_confirmation_button';

  static String tmtGameTmtScreenAppBarTime = 'tmt_game_tmt_screen_app_bar_time';
}

abstract class BaseMessages {
  String get tmtGameCircleBegin;

  String get tmtGameCircleEnd;

  String get tmtGamePartACompletedTitle;

  String get tmtGamePartACompletedBody;

  String get tmtGamePartBCompletedConfirmationButton;

  String get tmtGameTmtScreenAppBarTime;

  Map<String, String> get messages => {
        TMTGame.tmtGameCircleBegin: tmtGameCircleBegin,
        TMTGame.tmtGameCircleEnd: tmtGameCircleEnd,
        TMTGame.tmtGamePartACompletedTitle: tmtGamePartACompletedTitle,
        TMTGame.tmtGamePartACompletedBody: tmtGamePartACompletedBody,
        TMTGame.tmtGamePartBCompletedConfirmationButton:
            tmtGamePartBCompletedConfirmationButton,
        TMTGame.tmtGameTmtScreenAppBarTime: tmtGameTmtScreenAppBarTime,
      };
}
