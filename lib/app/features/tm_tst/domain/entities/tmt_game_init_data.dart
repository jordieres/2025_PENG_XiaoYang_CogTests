import 'package:msdtmt/app/features/tm_tst/domain/entities/tmt_game_hand_used.dart';

class TmtGameInitData {

  final TmtGameHandUsed tmtGameHandUsed;
  final String tmtGameCodeId;

  TmtGameInitData({
    required this.tmtGameHandUsed,
    required this.tmtGameCodeId,
  });
}
