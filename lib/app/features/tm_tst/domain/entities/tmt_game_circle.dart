import 'dart:ui';

enum TmtGameType {
  TMTA,
  TMTB,
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
}
