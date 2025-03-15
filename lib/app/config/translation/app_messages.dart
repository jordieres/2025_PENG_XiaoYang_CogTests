part of 'app_translations.dart';

class TMTGame {
  static String tmtGameCircleBegin = 'tmt_game_circle_begin';
  static String tmtGameCircleEnd = 'tmt_game_circle_end';
}

abstract class BaseMessages {
  String get tmtGameCircleBegin;
  String get tmtGameCircleEnd;

  Map<String, String> get messages => {
        TMTGame.tmtGameCircleBegin: tmtGameCircleBegin,
        TMTGame.tmtGameCircleEnd: tmtGameCircleEnd,
      };
}
