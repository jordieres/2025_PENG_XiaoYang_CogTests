import 'package:flutter/material.dart';

/// This class Paints circles and lines of the TMT test.
class TmtPainter extends CustomPainter {
  static const double circleRadius = 30;

  final List<Offset> allPoints;
  final List<Offset> connectedPoints;
  final Offset? currentDragPosition;

  TmtPainter(this.allPoints, this.connectedPoints, this.currentDragPosition);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    final Paint circlePaint = Paint()..color = Colors.blue;

    _drawDragLine(canvas, linePaint);
    _drawConnectedLines(canvas, linePaint);
    _drawCircles(canvas, circlePaint);
  }

  _drawDragLine(Canvas canvas, Paint linePaint) {
    if (connectedPoints.isNotEmpty && currentDragPosition != null) {
      canvas.drawLine(connectedPoints.last, currentDragPosition!, linePaint);
    }
  }

  _drawConnectedLines(Canvas canvas, Paint linePaint) {
    {
      for (int i = 1; i < connectedPoints.length; i++) {
        canvas.drawLine(connectedPoints[i - 1], connectedPoints[i], linePaint);
      }
    }
  }

  _drawCircles(Canvas canvas, Paint circlePaint) {
    for (int i = 0; i < allPoints.length; i++) {
      canvas.drawCircle(allPoints[i], circleRadius, circlePaint);

      Color color = Colors.white;
      if (i == 24) {
        color = Colors.red;
      } else {
        color = Colors.white;
      }

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: TextStyle(color: color, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, allPoints[i] - Offset(6, 6));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
