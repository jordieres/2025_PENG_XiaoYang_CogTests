import 'dart:ui';

import 'package:msdtmt/app/features/tm_tst/domain/usecases/tmt_game_calculate.dart';

enum TmtGameType {
  TMT_TEST_A(),
  TMT_TEST_B(),
  TMT_PRACTICE_A(),
  TMT_PRACTICE_B(),
  TMT_BOTH_PRACTICE();
}

enum TmtGameCircleTextType {
  NUMBER,
  NUMBER_WITH_LETTER,
}

class TmtGameCircle {
  final int order; // order since 1 not like index since 0
  final String text;
  final Offset offset;

  TmtGameCircle({
    required this.order,
    required this.text,
    required this.offset,
  });

  bool isFirst() {
    return order == 1;
  }

  bool isPointInsideCircle(Offset point) {
    return TmtGameCalculate.isPointInCircle(offset, point);
  }
}
