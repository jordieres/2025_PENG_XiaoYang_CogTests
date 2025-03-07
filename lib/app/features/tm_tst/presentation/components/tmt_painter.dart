import 'package:flutter/material.dart';

import '../../../../config/themes/AppColors.dart';
import '../../domain/entities/tmt_game_variable.dart';

class TmtPainter extends CustomPainter {
  final List<Offset> allPoints;
  final List<Offset> connectedPoints;
  final Offset? currentDragPosition;
  final List<Offset> dragPath;
  final List<List<Offset>> paths;
  final Offset? errorCircle;
  final int nextCircleIndex;
  final List<Offset> errorPath;
  final bool hasError;
  final bool lasTimeHasError;
  final bool isCheatModeEnabled;

  TmtPainter({
    required this.allPoints,
    required this.connectedPoints,
    required this.currentDragPosition,
    required this.dragPath,
    required this.paths,
    this.errorCircle,
    this.nextCircleIndex = 0,
    this.errorPath = const [],
    this.hasError = false,
    this.lasTimeHasError = false,
    this.isCheatModeEnabled = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawCorrectPathsLines(canvas);
    _drawCircles(canvas);

    // Draw error path if it exists
    if (hasError && errorPath.isNotEmpty) {
      _drawErrorPath(canvas);
    } else {
      _drawDragPath(canvas);
    }
  }

  void _drawCorrectPathsLines(Canvas canvas) {
    final Paint linePaint = Paint()
      ..color = AppColors.testTMTCorrectCircleStroke.withAlpha(40)
      ..strokeWidth = TmtGameVariables.LINE_STROKE_WIDTH
      ..strokeCap = StrokeCap.butt
      ..blendMode = BlendMode.srcOver;

    for (var path in paths) {
      if (path.length > 1) {
        for (int i = 1; i < path.length; i++) {
          canvas.drawLine(path[i - 1], path[i], linePaint);
        }
      }
    }
  }

  void _drawDragPath(Canvas canvas) {
    final Paint dragLinePaint = Paint()
      ..color = AppColors.mainBlackText
      ..strokeWidth = TmtGameVariables.LINE_STROKE_WIDTH
      ..strokeCap = StrokeCap.round;

    if (dragPath.length > 1) {
      for (int i = 1; i < dragPath.length; i++) {
        canvas.drawLine(dragPath[i - 1], dragPath[i], dragLinePaint);
      }
    }
  }

  void _drawErrorPath(Canvas canvas) {
    final Paint errorLinePaint = Paint()
      ..color = AppColors.testTMTIncorrectCircleStroke
      ..strokeWidth = TmtGameVariables.LINE_STROKE_WIDTH
      ..strokeCap = StrokeCap.round;

    if (errorPath.length > 1) {
      for (int i = 1; i < errorPath.length; i++) {
        canvas.drawLine(errorPath[i - 1], errorPath[i], errorLinePaint);
      }
    }
  }

  void _drawCircles(Canvas canvas) {
    for (int i = 0; i < allPoints.length; i++) {
      final currentOffset = allPoints[i];
      _drawNormalCircle(canvas, currentOffset);
      _drawConnectCircle(canvas, currentOffset);
      _drawModeCheatModeCircle(canvas, i, currentOffset);
      _drawErrorCircle(canvas, currentOffset);
      _drawWarningLastConnectCircle(canvas, currentOffset);
      _drawCircleText(canvas, i);
    }
  }

  _drawWarningLastConnectCircle(Canvas canvas, Offset currentOffset) {
    bool isLastConnectedCircle =
        connectedPoints.isNotEmpty && currentOffset == connectedPoints.last;

    if (isLastConnectedCircle && lasTimeHasError) {
      final Paint lastCirclePaint = Paint()
        ..color = AppColors.testTMTCurrentCircleStroke
        ..style = PaintingStyle.stroke
        ..strokeWidth = TmtGameVariables.CIRCLE_ERROR_CORRECT_STROKE_WIDTH;

      canvas.drawCircle(
          currentOffset, TmtGameVariables.circleRadius, lastCirclePaint);

      final Paint fillPaint = Paint()
        ..color = AppColors.testTMTCurrentCircleStroke.withValues(alpha: 0.2)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
          currentOffset, TmtGameVariables.circleRadius, fillPaint);
    }
  }

  _drawNormalCircle(Canvas canvas, Offset circleOffset) {
    final Paint fillPaint = Paint()
      ..color = AppColors.testTMTNormalCircleFill
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = AppColors.testTMTNormalLine
      ..strokeWidth = TmtGameVariables.CIRCLE_NORMAL_STROKE_WIDTH;

    final Paint touchAreaPaint = Paint()
      ..color = AppColors.testTMTBoardBackground.withValues(alpha: 0.1);

    if (!connectedPoints.contains(circleOffset) &&
        !(errorCircle != null && circleOffset == errorCircle)) {
      // draw touch area
      canvas.drawCircle(
          circleOffset,
          TmtGameVariables.circleRadius + TmtGameVariables.TOUCH_MARGIN,
          touchAreaPaint);

      canvas.drawCircle(circleOffset, TmtGameVariables.circleRadius, fillPaint);

      canvas.drawCircle(
          circleOffset, TmtGameVariables.circleRadius, strokePaint);
    }
  }

  _drawConnectCircle(Canvas canvas, Offset currentOffset) {
    if (connectedPoints.contains(currentOffset)) {
      final Paint strokePaint = Paint()
        ..style = PaintingStyle.stroke
        ..color = AppColors.testTMTCorrectCircleStroke
        ..strokeWidth = TmtGameVariables.CIRCLE_ERROR_CORRECT_STROKE_WIDTH;

      final Paint fillPaint = Paint()
        ..color = AppColors.testTMTBoardBackground
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
          currentOffset, TmtGameVariables.circleRadius, fillPaint);

      canvas.drawCircle(
          currentOffset, TmtGameVariables.circleRadius, strokePaint);
    }
  }

  _drawErrorCircle(Canvas canvas, Offset currentOffset) {
    if (errorCircle != null && currentOffset == errorCircle) {
      final Paint fillPaint = Paint()
        ..color = AppColors.testTMTIncorrectCircleStroke.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
          currentOffset, TmtGameVariables.circleRadius, fillPaint);

      final Paint errorPaint = Paint()
        ..color = AppColors.testTMTIncorrectCircleStroke
        ..strokeWidth = TmtGameVariables.CIRCLE_ERROR_CORRECT_STROKE_WIDTH
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(
          currentOffset, TmtGameVariables.circleRadius, errorPaint);

      final Paint xPaint = Paint()
        ..color = AppColors.testTMTIncorrectCircleStroke
        ..strokeWidth = TmtGameVariables.CIRCLE_ERROR_CORRECT_STROKE_WIDTH
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      double crossSize = TmtGameVariables.circleRadius * 0.7;
      Offset center = currentOffset;

      // draw cross
      canvas.drawLine(center - Offset(crossSize, crossSize),
          center + Offset(crossSize, crossSize), xPaint);
      canvas.drawLine(center + Offset(crossSize, -crossSize),
          center + Offset(-crossSize, crossSize), xPaint);
    }
  }

  _drawModeCheatModeCircle(
      Canvas canvas, int currentIndex, Offset currentOffset) {
    if (isCheatModeEnabled &&
        currentIndex == nextCircleIndex &&
        nextCircleIndex < allPoints.length &&
        !connectedPoints.contains(currentOffset)) {
      final Paint cheatPaint = Paint()
        ..color = AppColors.primaryBlue
        ..style = PaintingStyle.stroke
        ..strokeWidth = TmtGameVariables.CIRCLE_ERROR_CORRECT_STROKE_WIDTH;

      canvas.drawCircle(
          currentOffset, TmtGameVariables.circleRadius, cheatPaint);

      final Paint fillPaint = Paint()
        ..color = AppColors.primaryBlue.withValues(alpha: 0.2)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
          currentOffset, TmtGameVariables.circleRadius, fillPaint);
    }
  }

  _drawCircleText(Canvas canvas, int i) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: '${i + 1}',
          style: const TextStyle(color: AppColors.mainBlackText, fontSize: 12)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, allPoints[i] - const Offset(6, 6));
  }

  @override
  bool shouldRepaint(covariant TmtPainter oldDelegate) {
    return allPoints != oldDelegate.allPoints ||
        connectedPoints != oldDelegate.connectedPoints ||
        currentDragPosition != oldDelegate.currentDragPosition ||
        dragPath != oldDelegate.dragPath ||
        paths != oldDelegate.paths ||
        errorCircle != oldDelegate.errorCircle ||
        errorPath != oldDelegate.errorPath ||
        hasError != oldDelegate.hasError ||
        lasTimeHasError != oldDelegate.lasTimeHasError ||
        isCheatModeEnabled != oldDelegate.isCheatModeEnabled;
  }
}
