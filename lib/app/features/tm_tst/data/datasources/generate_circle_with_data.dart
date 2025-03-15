import 'dart:ui';

import '../../domain/entities/tmt_game_circle.dart';

class GenerateCircleWithData {
  final TmtGameCircleTextType tmtGameCircleTextType;

  GenerateCircleWithData({
    required this.tmtGameCircleTextType,
  });

  List<TmtGameCircle> generateCircle(List<Offset> circles) {
    List<TmtGameCircle> points = [];
    for (int i = 0; i < circles.length; i++) {
      points.add(TmtGameCircle(
        order: i + 1,
        text: _getCircleText(i),
        isNumber: _isNumber(i),
        offset: circles[i],
      ));
    }
    return points;
  }

  bool _isNumber(int index) {
    if (tmtGameCircleTextType == TmtGameCircleTextType.NUMBER) {
      return true;
    } else {
      if (index % 2 == 0) {
        return true;
      } else {
        return false;
      }
    }
  }

  String _getCircleText(int index) {
    if (tmtGameCircleTextType == TmtGameCircleTextType.NUMBER) {
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
