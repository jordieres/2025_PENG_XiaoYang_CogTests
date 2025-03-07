import 'dart:ui';

import 'package:msdtmt/app/features/tm_tst/domain/entities/tmt_game_variable.dart';

class TmtGameCalculate {
  /// Checks whether a given point is located inside a specified circle.
  ///
  /// This method calculates the Euclidean distance between a point `(xp, yp)`
  /// and the center of a circle `(xc, yc)` and compares it with the radius.
  ///
  /// Steps performed by this method:
  ///
  /// 1. Calculate the distance between the point and the center using the formula:
  ///
  ///    d = sqrt((xp - xc)² + (yp - yc)²)
  ///
  /// 2. Compare this distance with the radius:
  ///
  ///    - If d < radius, the point is inside the circle.
  ///    - If d == radius, the point lies exactly on the circle.
  ///    - If d > radius, the point lies outside the circle.
  static bool isPointInCircle(Offset circle, double radius, Offset point) {
    double distanceSquared = (point.dx - circle.dx) * (point.dx - circle.dx) +
        (point.dy - circle.dy) * (point.dy - circle.dy);
    return distanceSquared <= radius * radius;
  }

  static bool isConnectWithCircle(
      Offset currentDragOffset, Offset nextCircleOffset) {
    double distance = (currentDragOffset - nextCircleOffset).distance;
    return distance <= TmtGameVariables.CONNECT_DISTANCE;
  }

  static double getBoardMinX() {
    return TmtGameVariables.circleRadius + TmtGameVariables.BOARD_MARGIN;
  }

  static double getBoardMaxX(double constraintsMaxWidth) {
    return constraintsMaxWidth -
        TmtGameVariables.circleRadius -
        TmtGameVariables.BOARD_MARGIN;
  }

  static double getBoardMinY() {
    return TmtGameVariables.circleRadius + TmtGameVariables.BOARD_MARGIN;
  }

  static double getBoardMaxY(double constraintsMaxHeight) {
    return constraintsMaxHeight -
        TmtGameVariables.circleRadius -
        TmtGameVariables.BOARD_MARGIN;
  }

  static Offset closestPointOnCircle(
      Offset center, double radius, Offset point) {
    // Calculate point vector from center to target
    Offset vector = point - center;

    // Calculate the length of the vector
    double distance = vector.distance;

    if (distance == 0) {
      return center + Offset(radius, 0);
    }

    // Normalize the vector and scale it to the circle's radius
    Offset normalizedVector = vector / distance * radius;

    return center + normalizedVector;
  }
}
