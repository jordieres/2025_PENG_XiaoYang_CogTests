import 'package:flutter/material.dart';

class TmtPainter extends CustomPainter {
  static const double circleRadius = 20;
  final List<Offset> allPoints;
  final List<Offset> connectedPoints;
  final Offset? currentDragPosition;
  final List<Offset> dragPath;
  final List<List<Offset>> paths;

  TmtPainter(this.allPoints, this.connectedPoints, this.currentDragPosition, this.dragPath, this.paths);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final Paint circlePaint = Paint()..color = Colors.blue;

    _drawPaths(canvas, linePaint);
    _drawDragPath(canvas, linePaint);
    _drawCircles(canvas, circlePaint);
  }

  void _drawPaths(Canvas canvas, Paint linePaint) {
    for (var path in paths) {
      if (path.length > 1) {
        for (int i = 1; i < path.length; i++) {
          canvas.drawLine(path[i - 1], path[i], linePaint);
        }
      }
    }
  }

  void _drawDragPath(Canvas canvas, Paint linePaint) {
    if (dragPath.length > 1) {
      for (int i = 1; i < dragPath.length; i++) {
        canvas.drawLine(dragPath[i - 1], dragPath[i], linePaint);
      }
    }
  }


  void _drawCircles(Canvas canvas, Paint circlePaint) {
    for (int i = 0; i < allPoints.length; i++) {
      canvas.drawCircle(allPoints[i], circleRadius, circlePaint);

      TextPainter textPainter = TextPainter(
        text: TextSpan(text: '${i + 1}', style: TextStyle(color: Colors.white, fontSize: 12)),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, allPoints[i] - Offset(6, 6));
    }
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
