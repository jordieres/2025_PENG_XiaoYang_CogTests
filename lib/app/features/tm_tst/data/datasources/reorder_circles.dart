import 'dart:math';
import 'dart:ui';

import 'package:msdtmt/app/features/tm_tst/data/datasources/random_grid_sampler.dart';
import 'package:msdtmt/app/features/tm_tst/domian/entities/tmt_game_variable.dart';

class ReorderCircles {
  static final int _maxRegenerateCircleAttemptsInPostProcessReorder =
      10; // maximum attempts to regenerate a circle
  static final int _maxRegenerateInWholeAreaInPostProcessReorder =
      5; // maximum attempts to regenerate a circle in postProcessReorder

  final double minX; // left boundary
  final double maxX; // right boundary
  final double minY; // top boundary
  final double maxY; // bottom boundary
  final double minDistance; // minimum distance between points

  final double cellWidth;
  final double cellHeight;

  final Random _random = Random();

  // ============ 1) Create auxiliary list ============
  List<CircleGenerator> aux = [];

  ReorderCircles({
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.minDistance,
    required this.cellWidth,
    required this.cellHeight,
  });

  /// 1: Create an auxiliary list to hold the circles in their final sorted order.
  /// 2: For each circle, count the number of points it can directly connect to.
  /// 3: Select the circle with the fewest connectable points, record its original order, and set its order to 1.
  /// 4: Find the circle in the original list that originally had order 1 and swap its order with the selected circle.
  /// 5: Add the selected circle to the auxiliary list, remove it from the original list, and remove its offset from the connectable lists of the remaining circles.
  /// 6: Repeat steps 3–5: starting from the circle just set to order 1, continue assigning orders 2, 3, …, n by selecting the circle with the least connectable points.
  /// 7: If a circle has an empty connectable list (i.e. no connectable points), attempt to regenerate its position.
  void postProcessReorder(List<CircleGenerator> circles) {
    for (int i = 0; i < circles.length; i++) {
      circles[i].order = i + 1;
    }

    // ============ 2) Count connectable points ============
    for (CircleGenerator c in circles) {
      c.connectableOffsets = _buildConnectableOffsets(c, circles);
    }

    // ============ 3) Sort by connectable points ============
    circles.sort((a, b) =>
        a.connectableOffsets.length.compareTo(b.connectableOffsets.length));

    _getFirstCircle(circles);

    // ============ Repeat for remaining circles ============
    _reorderDependNumberOfConnectableOffsets(circles);

    // If there are still circles left, add them to the end of the list
    while (circles.isNotEmpty) {
      aux.add(circles.removeAt(0));
    }

    circles.clear();
    circles.addAll(aux);

    circles.sort((a, b) => a.order.compareTo(b.order));
  }

  void _getFirstCircle(List<CircleGenerator> circles) {
    // Select first circle, set its order to 1
    if (circles.isNotEmpty) {
      CircleGenerator least = circles.first;
      int oldOrder = least.order;
      least.order = 1;

      // Find order 1 circle in original list, swap with selected circle
      CircleGenerator? circleHad1 = circles.firstWhere(
        (cc) => cc != least && cc.order == 1,
        orElse: () => least,
      );
      if (circleHad1 != least) {
        circleHad1.order = oldOrder;
      }

      aux.add(least);
      circles.remove(least);

      // Remove offset from connectable lists
      for (CircleGenerator c in circles) {
        c.connectableOffsets.remove(least.offset);
      }
    }
  }

  void _reorderDependNumberOfConnectableOffsets(List<CircleGenerator> circles) {
    while (aux.length < (aux.length + circles.length)) {
      if (aux.isEmpty) break;

      CircleGenerator current = aux.last;
      int nextOrder = aux.length + 1;

      // Find in Origin CircleGenerator all connectableOffsets with current offset
      List<CircleGenerator> candidates = [];
      for (CircleGenerator c in circles) {
        if (current.connectableOffsets.contains(c.offset)) {
          candidates.add(c);
        }
      }

      // If no candidates, regenerate current circle
      if (!_regenerateCircleIfNoConnectableOffsets(
          current, circles, candidates)) {
        break;
      }
      candidates.sort((a, b) =>
          a.connectableOffsets.length.compareTo(b.connectableOffsets.length));
      CircleGenerator? nextCircle =
          candidates.isNotEmpty ? candidates.first : null;
      if (nextCircle == null) {
        break;
      }

      int oldOrderNext = nextCircle.order;
      nextCircle.order = nextOrder;
      CircleGenerator? circleHadNextOrder = circles.firstWhere(
        (cc) => cc != nextCircle && cc.order == nextOrder,
        orElse: () => nextCircle,
      );
      if (circleHadNextOrder != nextCircle) {
        circleHadNextOrder.order = oldOrderNext;
      }

      aux.add(nextCircle);
      circles.remove(nextCircle);
      for (CircleGenerator c in circles) {
        c.connectableOffsets.remove(nextCircle.offset);
      }
    }
  }

  bool _regenerateCircleIfNoConnectableOffsets(CircleGenerator current,
      List<CircleGenerator> circles, List<CircleGenerator> candidates) {
    if (candidates.isEmpty) {
      bool success = false;
      for (int i = 0;
          i < _maxRegenerateCircleAttemptsInPostProcessReorder;
          i++) {
        if (_reGenerateOneCircleInSameCell(
            current, aux + circles, minDistance)) {
          current.connectableOffsets =
              _buildConnectableOffsets(current, aux + circles);
          candidates.clear();
          for (CircleGenerator c in circles) {
            if (current.connectableOffsets.contains(c.offset)) {
              candidates.add(c);
            }
          }
          if (candidates.isNotEmpty) {
            success = true;
            break;
          }
        }
      }
      return success;
    }
    return true;
  }

  List<Offset> _buildConnectableOffsets(
      CircleGenerator c, List<CircleGenerator> all) {
    List<Offset> results = [];
    double circleRadius = TmtGameVariables.circleRadius;

    for (CircleGenerator other in all) {
      if (other == c) continue;
      if (!_isLineBlockedByAnyCircle(
          c.offset, other.offset, all, circleRadius)) {
        results.add(other.offset);
      }
    }
    return results;
  }

  bool _isLineBlockedByAnyCircle(Offset start, Offset end,
      List<CircleGenerator> all, double circleRadius) {
    for (CircleGenerator cg in all) {
      if ((cg.offset - start).distance < 1e-8 ||
          (cg.offset - end).distance < 1e-8) {
        continue;
      }

      if (_lineBlockedByCircle(start, end, cg.offset, circleRadius)) {
        return true;
      }
    }
    return false;
  }

  bool _lineBlockedByCircle(
      Offset A, Offset B, Offset center, double circleRadius) {
    const double epsilon = 1e-8;
    if ((center - A).distance < epsilon || (center - B).distance < epsilon) {
      return false;
    }

    final AB = B - A;
    final AC = center - A;
    final double ab2 = AB.dx * AB.dx + AB.dy * AB.dy; // |AB|^2

    if (ab2 < 1e-12) {
      return (A - center).distance <= circleRadius;
    }

    final double dot = (AC.dx * AB.dx + AC.dy * AB.dy); // AC dot AB
    final double t = dot / ab2;

    Offset P;
    if (t < 0.0) {
      P = A;
    } else if (t > 1.0) {
      P = B;
    } else {
      P = Offset(A.dx + t * AB.dx, A.dy + t * AB.dy);
    }
    double distPC = (P - center).distance;
    return distPC < circleRadius;
  }

  bool _reGenerateOneCircleInSameCell(
    CircleGenerator circle,
    List<CircleGenerator> all,
    double distance,
  ) {
    if (circle.rowIndex < 0 || circle.columIndex < 0) {
      return _reGenerateOneCircleInWholeArea(circle, all, distance);
    }

    final oldOffset = circle.offset;
    bool success = false;

    final cellLeft = circle.originalPoint.cellLeft;
    final cellTop = circle.originalPoint.cellTop;

    for (int attempt = 0;
        attempt < _maxRegenerateInWholeAreaInPostProcessReorder;
        attempt++) {
      final randomX = _random.nextDouble() * cellWidth;
      final randomY = _random.nextDouble() * cellHeight;
      final newX = cellLeft + randomX;
      final newY = cellTop + randomY;
      final candidate = Offset(newX, newY);

      if (_isValidPointForRegen(candidate, circle, all, distance)) {
        circle.offset = candidate;
        success = true;
        break;
      }
    }

    if (!success) {
      // if can not generate a new offset, restore the old offset
      circle.offset = oldOffset;
    }
    return success;
  }

  bool _reGenerateOneCircleInWholeArea(
      CircleGenerator circle, List<CircleGenerator> all, double distance) {
    final oldOffset = circle.offset;
    bool success = false;

    for (int i = 0; i < _maxRegenerateInWholeAreaInPostProcessReorder; i++) {
      final width = maxX - minX;
      final height = maxY - minY;
      final x = minX + _random.nextDouble() * width;
      final y = minY + _random.nextDouble() * height;
      final candidate = Offset(x, y);

      if (_isValidPointForRegen(candidate, circle, all, distance)) {
        circle.offset = candidate;
        success = true;
        break;
      }
    }

    if (!success) {
      circle.offset = oldOffset;
    }
    return success;
  }

  bool _isValidPointForRegen(Offset candidate, CircleGenerator circle,
      List<CircleGenerator> all, double distance) {
    // Define a very small tolerance value for floating-point comparisons.
    const double epsilon = 1e-8;
    // If the candidate point is nearly identical to the circle's current offset (within the tolerance),
    // Exclude it self
    if ((candidate - circle.offset).distance < epsilon) {
      return false;
    }

    for (final other in all) {
      if (other == circle) continue;
      if ((other.offset - candidate).distance < distance) {
        return false;
      }
    }
    return true;
  }
}
