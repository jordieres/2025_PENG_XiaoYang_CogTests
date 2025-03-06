import 'dart:math';
import 'dart:ui';

import 'package:msdtmt/app/features/tm_tst/data/datasources/reorder_circles.dart';


///Generate random points in a grid.
class RandomGridSampler {
  static final int _maxAttemptsInCellRandom =
      10; // maximum attempts to place a point
  static final int _fallbackMaxAttempts =
      100; // maximum attempts to fallback random fill
  static final int _maxIterationsWhenAdjusting =
      10; // maximum iterations when adjusting minDistance
  static final double _distanceShrinkFactor =
      0.9; // shrink factor when adjusting minDistance

  final Random _random = Random();

  final double minX; // left boundary
  final double maxX; // right boundary
  final double minY; // top boundary
  final double maxY; // bottom boundary
  final double minDistance; // minimum distance between points

  double _cellWidth = 0.0;
  double _cellHeight = 0.0;

  RandomGridSampler({
    required this.minDistance,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
  });

  /// 1: Divide the area into grid cells
  /// 2: Calculate height and width of each cell
  /// 3: Calculate origin point of each cell
  /// 4: According origin point, generate random point in each cell
  /// 5: Check if the point is far enough from existing points, will attempt 5 times
  /// 6: If not enough points, fallback to random fill with 100 attempts
  /// 7: If still not enough points, reduce minDistance and try again
  /// 8: Repeat step 5-7 for 10 times
  /// 1: Divide the area into grid cells
  /// 2: Calculate height and width of each cell
  /// 3: Calculate origin point of each cell
  /// 4: According origin point, generate random point in each cell
  /// 5: Check if the point is far enough from existing points, will attempt 5 times
  /// 6: If not enough points, fallback to random fill with 100 attempts
  /// 7: If still not enough points, reduce minDistance and try again
  /// 8: Repeat step 5-7 for 10 times
  List<Offset> generatePoints(int circleNumber) {
    double currentMinDist = minDistance;

    for (int iteration = 0;
        iteration < _maxIterationsWhenAdjusting;
        iteration++) {
      final listCircleGenerator =
          _tryPlacePointsWithDistance(circleNumber, currentMinDist);

      if (listCircleGenerator.length >= circleNumber) {
        listCircleGenerator.shuffle(_random);
        ReorderCircles(
           minX: minX,
           maxX: maxX,
           minY: minY,
           maxY: maxY,
           minDistance: minDistance,
           cellWidth: _cellWidth,
           cellHeight: _cellHeight,
        ).postProcessReorder(listCircleGenerator);
        return listCircleGenerator
            .take(circleNumber)
            .map((e) => e.offset)
            .toList();
      } else {
        // reduce minDistance and try again
        currentMinDist *= _distanceShrinkFactor;
      }
    }
    return [];
  }

  List<CircleGenerator> _tryPlacePointsWithDistance(
      int desiredCount, double distance) {
    final gridPoints = _generateGridRandomPoints(desiredCount, distance);

    if (gridPoints.length < desiredCount) {
      final needed = desiredCount - gridPoints.length;
      _fallbackRandomFill(gridPoints, needed, distance);
    }

    return gridPoints;
  }

  List<CircleGenerator> _generateGridRandomPoints(
      int desiredCount, double distance) {
    final points = <CircleGenerator>[];

    final width = maxX - minX;
    final height = maxY - minY;

    final approx = sqrt(desiredCount);
    final rows = approx.ceil();
    final cols = (desiredCount / rows).ceil();

    final cellW = width / cols;
    final cellH = height / rows;

    _cellWidth = cellW;
    _cellHeight = cellH;

    cellLoop:
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        if (points.length >= desiredCount) break cellLoop;

        final cellLeft = minX + c * cellW;
        final cellTop = minY + r * cellH;

        for (int attempt = 0; attempt < _maxAttemptsInCellRandom; attempt++) {
          final randomX = _random.nextDouble() * cellW;
          final randomY = _random.nextDouble() * cellH;
          final x = cellLeft + randomX;
          final y = cellTop + randomY;
          final candidate = Offset(x, y);

          if (_isFarEnough(candidate, points, distance)) {
            final circle = CircleGenerator(
              offset: candidate,
              originalPoint:
                  CellOriginalPoint(cellLeft: cellLeft, cellTop: cellTop),
              rowIndex: r,
              columIndex: c,
              order: 0,
            );
            points.add(circle);
            break;
          }
        }
      }
    }

    return points;
  }

  void _fallbackRandomFill(
      List<CircleGenerator> points, int neededCount, double distance) {
    int added = 0;
    int attempts = 0;

    final width = maxX - minX;
    final height = maxY - minY;

    while (added < neededCount && attempts < _fallbackMaxAttempts) {
      attempts++;
      final x = minX + _random.nextDouble() * width;
      final y = minY + _random.nextDouble() * height;
      final candidate = Offset(x, y);
      if (_isFarEnough(candidate, points, distance)) {
        final circle = CircleGenerator(
          offset: candidate,
          originalPoint: CellOriginalPoint(cellLeft: 0, cellTop: 0),
          rowIndex: -1,
          columIndex: -1,
          order: 0,
        );
        points.add(circle);
        added++;
      }
    }
  }

  bool _isFarEnough(
      Offset candidate, List<CircleGenerator> existing, double distance) {
    for (final p in existing) {
      if ((p.offset - candidate).distance < distance) {
        return false;
      }
    }
    return true;
  }
}

class CircleGenerator {
  Offset offset;
  CellOriginalPoint originalPoint;
  int rowIndex;
  int columIndex;
  int order;

  List<Offset> connectableOffsets = [];

  CircleGenerator({
    required this.offset,
    required this.originalPoint,
    required this.rowIndex,
    required this.columIndex,
    required this.order,
  });
}

class CellOriginalPoint {
  double cellLeft;
  double cellTop;

  CellOriginalPoint({
    required this.cellLeft,
    required this.cellTop,
  });
}
