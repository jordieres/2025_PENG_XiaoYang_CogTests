import 'dart:math';
import 'dart:ui';

class SimpleGenerateRandomCircle {
  final double minDistance;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;

  final Random _random = Random();

  SimpleGenerateRandomCircle({
    required this.minDistance,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
  });

  List<Offset> generatePoints(int desiredCount) {
    final List<Offset> _circles = [];
    while (_circles.length < desiredCount) {
      Offset newPoint = _generateValidCircle(_random, minX, maxX, minY, maxY);
      bool isTooClose =
          _circles.any((p) => (p - newPoint).distance < minDistance);

      if (!isTooClose) {
        _circles.add(newPoint);
      }
    }
    return _circles;
  }

  Offset _generateValidCircle(
      Random random, double minX, double maxX, double minY, double maxY) {
    while (true) {
      double x = minX + random.nextDouble() * (maxX - minX);
      double y = minY + random.nextDouble() * (maxY - minY);
      if (_isWithinBounds(x, y, minX, maxX, minY, maxY)) {
        return Offset(x, y);
      }
    }
  }

  bool _isWithinBounds(
      double x, double y, double minX, double maxX, double minY, double maxY) {
    return (x >= minX && x <= maxX) && (y >= minY && y <= maxY);
  }
}
