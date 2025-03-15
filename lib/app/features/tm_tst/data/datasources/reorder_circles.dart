import 'dart:math';
import 'dart:ui';

import 'package:msdtmt/app/features/tm_tst/data/datasources/random_grid_sampler.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/tmt_game_variable.dart';
import 'package:msdtmt/app/utils/helpers/app_helpers.dart';

class ReorderCircles {
  static final int _maxRegenerateCircleAttemptsInPostProcessReorder =
      10; // maximum attempts to regenerate a circle
  static final int _maxRegenerateInWholeAreaInPostProcessReorder =
      5; // maximum attempts to regenerate a circle in postProcessReorder

  static const double effectiveRadiusFactor = 0.75;

  // factor to reduce the radius of the circle to avoid overlap

  // factor to adjust the optimal distance between circles
  static const double optimalDistanceFactorLargeTablet = 3.8;
  static const double optimalDistanceFactorMediumTablet = 3.5;
  static const double optimalDistanceFactorSmallTablet = 3.2;

  static const double optimalDistanceFactorPhone = 3;

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
  /// 2: Get first circle randomly, set its order to 1.
  /// 3: For each circle, count the number of points it can directly connect to.
  /// 4: Select the circle with the fewest connectable points, record its original order, and set its order to 2.
  /// 5: Find the circle in the original list that originally had order 2 and swap its order with the selected circle.
  /// 6: Add the selected circle to the auxiliary list, remove it from the original list, and remove its offset from the connectable lists of the remaining circles.
  /// 7: Repeat steps 3–5: starting from the circle just set to order 2, continue assigning orders 3, 4, …, n by selecting the circle with the least connectable points.
  /// 8: If a circle has an empty connectable list (i.e. no connectable points), attempt to regenerate its position.
  void postProcessReorder(List<CircleGenerator> circles) {
    for (int i = 0; i < circles.length; i++) {
      circles[i].order = i + 1;
    }

    // ============ 2) Count connectable points ============
    for (CircleGenerator c in circles) {
      c.connectableOffsets = _buildConnectableOffsets(c, circles);
    }

    _getFirstCircle(circles);

    //============ 3) Sort by connectable points ============
    circles.sort((a, b) =>
        a.connectableOffsets.length.compareTo(b.connectableOffsets.length));

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
      CircleGenerator randomCircle = circles[_random.nextInt(circles.length)];
      int oldOrder = randomCircle.order;
      randomCircle.order = 1;

      // Find order 1 circle in original list, swap with selected circle
      CircleGenerator? circleHad1 = circles.firstWhere(
        (cc) => cc != randomCircle && cc.order == 1,
        orElse: () => randomCircle,
      );
      if (circleHad1 != randomCircle) {
        circleHad1.order = oldOrder;
      }

      aux.add(randomCircle);
      circles.remove(randomCircle);

      // Remove offset from connectable lists
      for (CircleGenerator c in circles) {
        c.connectableOffsets.remove(randomCircle.offset);
      }

      //recalculate connectableOffsets
      for (CircleGenerator c in circles) {
        c.connectableOffsets = _buildConnectableOffsets(c, circles);
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

      // Sort candidates by number of connectableOffsets
      candidates.sort((a, b) =>
          a.connectableOffsets.length.compareTo(b.connectableOffsets.length));

      // find the group of candidates with the fewest connectable points
      int minConnectable = candidates.isNotEmpty
          ? candidates.first.connectableOffsets.length
          : 0;
      List<CircleGenerator> minConnectableCandidates = candidates
          .where((c) => c.connectableOffsets.length == minConnectable)
          .toList();

      // If there are multiple candidates with the same minimum number of connectable points, choose the one that is at a moderate distance
      CircleGenerator? nextCircle;
      if (minConnectableCandidates.length > 1) {
        // calculate the distance between the current circle and each candidate
        minConnectableCandidates.sort((a, b) {
          double distanceA = (a.offset - current.offset).distance;
          double distanceB = (b.offset - current.offset).distance;

          double optimalDistance = minDistance * _getOptimalDistance();
          double scoreA = (distanceA - optimalDistance).abs();
          double scoreB = (distanceB - optimalDistance).abs();

          return scoreA.compareTo(scoreB);
        });

        nextCircle = minConnectableCandidates.first;
      } else {
        nextCircle = minConnectableCandidates.isNotEmpty
            ? minConnectableCandidates.first
            : null;
      }

      if (nextCircle == null) {
        break;
      }

      int oldOrderNext = nextCircle.order;
      nextCircle.order = nextOrder;
      CircleGenerator? circleHadNextOrder = circles.firstWhere(
        (cc) => cc != nextCircle && cc.order == nextOrder,
        orElse: () => nextCircle!,
      );
      if (circleHadNextOrder != nextCircle) {
        circleHadNextOrder.order = oldOrderNext;
      }

      aux.add(nextCircle);
      circles.remove(nextCircle);
      for (CircleGenerator c in circles) {
        c.connectableOffsets.remove(nextCircle.offset);
      }

      //recalculate connectableOffsets
      for (CircleGenerator c in circles) {
        c.connectableOffsets = _buildConnectableOffsets(c, circles);
      }
    }
  }

  double _getOptimalDistance() {
    final deviceType = DeviceHelper.deviceType;
    switch (deviceType) {
      case DeviceType.largeTablet:
        return optimalDistanceFactorLargeTablet;
      case DeviceType.mediumTablet:
        return optimalDistanceFactorMediumTablet;
      case DeviceType.smallTablet:
        return optimalDistanceFactorSmallTablet;
      case DeviceType.largePhone:
        return optimalDistanceFactorPhone;
      case DeviceType.mediumPhone:
        return optimalDistanceFactorPhone;
      default:
        return optimalDistanceFactorPhone;
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

  bool _isLineBlockedByAnyCircle(Offset center1, Offset center2,
      List<CircleGenerator> all, double circleRadius) {
    // Calculate the vector from the center of the first circle to the center of the second circle
    final Offset direction = center2 - center1;
    final double distance = direction.distance;

    // if the circles are too close, return false
    if (distance < 2 * circleRadius) {
      return false;
    }

    // Calculate the normalized direction vector
    final Offset normalizedDir =
        Offset(direction.dx / distance, direction.dy / distance);

    // Calculate the unit vector perpendicular to the direction
    final Offset perpendicular = Offset(-normalizedDir.dy, normalizedDir.dx);

    // Calculate the corridor width between the two circles (the sum of the radii of the two circles)
    final double corridorWidth = 2 * circleRadius;

    // Check all other circles
    for (CircleGenerator cg in all) {
      // Skip the start and end circles
      if ((cg.offset - center1).distance < 1e-8 ||
          (cg.offset - center2).distance < 1e-8) {
        continue;
      }

      // Calculate the vector from the first circle center to the other circle center
      final Offset toOtherCircle = cg.offset - center1;

      // Calculate the projection distance of the other circle in the direction of the line
      final double projAlongLine = toOtherCircle.dx * normalizedDir.dx +
          toOtherCircle.dy * normalizedDir.dy;

      // if the projection is between the two circles
      if (projAlongLine > 0 && projAlongLine < distance) {
        // Calculate the perpendicular distance of the other circle to the line
        final double projPerpendicular = (toOtherCircle.dx * perpendicular.dx +
                toOtherCircle.dy * perpendicular.dy)
            .abs();

        // If the perpendicular distance is less than half the corridor width plus the radius of the other circle, it is blocked
        if (projPerpendicular <
            (corridorWidth / 2) + (circleRadius * effectiveRadiusFactor)) {
          return true;
        }
      }
    }

    return false;
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
