import 'dart:ui';

import '../../domain/entities/tmt_game_circle.dart';

class GenerateCircleWithData {
  final TmtGameType tmtGameType;

  GenerateCircleWithData({
    required this.tmtGameType,
  });

  List<TmtGameCircle> generateCircle(List<Offset> circles) {
    List<TmtGameCircle> points = [];
    for (int i = 0; i < circles.length; i++) {
      points.add(TmtGameCircle(
        order: i + 1,
        text: _getCircleText(i),
        offset: circles[i],
      ));
    }
    return points;
  }

  String _getCircleText(int index) {
    if (tmtGameType == TmtGameType.TMTA) {
      return (index + 1).toString();
    } else {
      if (index % 2 == 0) {
        return '${(index / 2).floor() + 1}';
      } else {
        return String.fromCharCode('A'.codeUnitAt(0) + (index / 2).floor());
      }
    }
  }
}
