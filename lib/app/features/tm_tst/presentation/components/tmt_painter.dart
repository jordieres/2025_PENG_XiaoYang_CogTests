import 'package:flutter/material.dart';

import '../../domian/entities/tmt_game_variable.dart';

class TmtPainter extends CustomPainter {

  final List<Offset> allPoints;
  final List<Offset> connectedPoints;
  final Offset? currentDragPosition;
  final List<Offset> dragPath;
  final List<List<Offset>> paths;
  final Offset? errorCircle;
  final int nextCircleIndex;

  TmtPainter(
      this.allPoints,
      this.connectedPoints,
      this.currentDragPosition,
      this.dragPath,
      this.paths,
      [this.errorCircle,
        this.nextCircleIndex = 0]
      );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final Paint circlePaint = Paint()..color = Colors.blue;
    final Paint connectedCirclePaint = Paint()..color = Colors.green;
    final Paint errorCirclePaint = Paint()..color = Colors.red;
    final Paint nextCirclePaint = Paint()..color = Colors.orange;

    _drawPaths(canvas, linePaint);
    _drawDragPath(canvas, linePaint);
    _drawCircles(canvas, circlePaint, connectedCirclePaint, nextCirclePaint, errorCirclePaint);
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

  void _drawCircles(Canvas canvas, Paint circlePaint, Paint connectedCirclePaint,
      Paint nextCirclePaint, Paint errorCirclePaint) {
    final Paint touchAreaPaint = Paint()
      ..color = Colors.white.withOpacity(0.2);

    for (int i = 0; i < allPoints.length; i++) {

      Paint currentPaint = circlePaint;

      // paint connected circle
      if (connectedPoints.contains(allPoints[i])) {
        currentPaint = connectedCirclePaint;
      }
      // paint next circle
      else if (i == nextCircleIndex) {
        currentPaint = nextCirclePaint;
      }

      // paint error circle
      if (errorCircle != null && allPoints[i] == errorCircle) {
        currentPaint = errorCirclePaint;
      }

      // paint touch area
      canvas.drawCircle(allPoints[i], TmtGameVariables.circleRadius + TmtGameVariables.TOUCH_MARGIN, touchAreaPaint);

      // pain circle
      canvas.drawCircle(allPoints[i], TmtGameVariables.circleRadius, currentPaint);

      // paint text
      TextPainter textPainter = TextPainter(
        text: TextSpan(text: '${i + 1}', style: const TextStyle(color: Colors.white, fontSize: 12)),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, allPoints[i] - const Offset(6, 6));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}