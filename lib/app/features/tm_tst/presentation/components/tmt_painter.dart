import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/utils/helpers/app_helpers.dart';

import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/AppTextStyle.dart';
import '../../../../config/translation/app_translations.dart';
import '../../domain/entities/tmt_game_circle.dart';
import '../../domain/entities/tmt_game_variable.dart';

class TmtPainter extends CustomPainter {
  final List<TmtGameCircle> allCircles;
  final List<TmtGameCircle> connectedCircles;
  final Offset? currentDragPosition;
  final List<Offset> dragPath;
  final List<List<Offset>> paths;
  final TmtGameCircle? errorCircle;
  final int nextCircleIndex;
  final List<Offset> errorPath;
  final bool hasError;
  final bool lasTimeHasError;
  final bool isCheatModeEnabled;

  TmtPainter({
    required this.allCircles,
    required this.connectedCircles,
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

  bool get isDarkMode => Get.isDarkMode;

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
      ..color = isDarkMode ? AppColors.darkText : AppColors.mainBlackText
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
    for (int i = 0; i < allCircles.length; i++) {
      final currentCircle = allCircles[i];
      _drawNormalCircle(canvas, currentCircle);
      _drawConnectCircle(canvas, currentCircle);
      _drawModeCheatModeCircle(canvas, i, currentCircle);
      _drawErrorCircle(canvas, currentCircle);
      _drawWarningLastConnectCircle(canvas, currentCircle);
      _drawCircleText(canvas, currentCircle);
    }
  }

  _drawWarningLastConnectCircle(Canvas canvas, TmtGameCircle currentOffset) {
    bool isLastConnectedCircle =
        connectedCircles.isNotEmpty && currentOffset == connectedCircles.last;

    if (isLastConnectedCircle && lasTimeHasError) {
      final Paint lastCirclePaint = Paint()
        ..color = AppColors.testTMTCurrentCircleStroke
        ..style = PaintingStyle.stroke
        ..strokeWidth = TmtGameVariables.CIRCLE_ERROR_CORRECT_STROKE_WIDTH;

      canvas.drawCircle(
          currentOffset.offset, TmtGameVariables.circleRadius, lastCirclePaint);

      final Paint fillPaint = Paint()
        ..color = AppColors.testTMTCurrentCircleStroke.withAlpha(51)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
          currentOffset.offset, TmtGameVariables.circleRadius, fillPaint);
    }
  }

  _drawNormalCircle(Canvas canvas, TmtGameCircle circle) {
    final Paint fillPaint = Paint()
      ..color = isDarkMode ? AppColors.testTMTNormalCircleFillDark : AppColors.testTMTNormalCircleFill
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = isDarkMode ? AppColors.testTMTNormalLineDark : AppColors.testTMTNormalLine
      ..strokeWidth = TmtGameVariables.CIRCLE_NORMAL_STROKE_WIDTH;

    final Paint touchAreaPaint = Paint()
      ..color = (isDarkMode ? AppColors.testTMTBoardBackgroundDark : AppColors.testTMTBoardBackground).withAlpha(26);

    if (!connectedCircles.contains(circle) &&
        !(errorCircle != null && circle == errorCircle)) {
      // draw touch area
      canvas.drawCircle(
          circle.offset,
          TmtGameVariables.circleRadius + TmtGameVariables.TOUCH_MARGIN,
          touchAreaPaint);

      canvas.drawCircle(
          circle.offset, TmtGameVariables.circleRadius, fillPaint);

      canvas.drawCircle(
          circle.offset, TmtGameVariables.circleRadius, strokePaint);
    }
  }

  _drawConnectCircle(Canvas canvas, TmtGameCircle currentCircle) {
    if (connectedCircles.contains(currentCircle)) {
      final Paint strokePaint = Paint()
        ..style = PaintingStyle.stroke
        ..color = AppColors.testTMTCorrectCircleStroke
        ..strokeWidth = TmtGameVariables.CIRCLE_ERROR_CORRECT_STROKE_WIDTH;

      final Paint fillPaint = Paint()
        ..color = isDarkMode ? AppColors.testTMTBoardBackgroundDark : AppColors.testTMTBoardBackground
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
          currentCircle.offset, TmtGameVariables.circleRadius, fillPaint);

      canvas.drawCircle(
          currentCircle.offset, TmtGameVariables.circleRadius, strokePaint);
    }
  }

  _drawErrorCircle(Canvas canvas, TmtGameCircle currentCircle) {
    if (errorCircle != null && currentCircle == errorCircle) {
      final Paint fillPaint = Paint()
        ..color = AppColors.testTMTIncorrectCircleStroke.withAlpha(77)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
          currentCircle.offset, TmtGameVariables.circleRadius, fillPaint);

      final Paint errorPaint = Paint()
        ..color = AppColors.testTMTIncorrectCircleStroke
        ..strokeWidth = TmtGameVariables.CIRCLE_ERROR_CORRECT_STROKE_WIDTH
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(
          currentCircle.offset, TmtGameVariables.circleRadius, errorPaint);

      final Paint xPaint = Paint()
        ..color = AppColors.testTMTIncorrectCircleStroke
        ..strokeWidth = TmtGameVariables.CIRCLE_ERROR_CORRECT_STROKE_WIDTH
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      double crossSize = TmtGameVariables.circleRadius * 0.7;
      Offset center = currentCircle.offset;

      // draw cross
      canvas.drawLine(center - Offset(crossSize, crossSize),
          center + Offset(crossSize, crossSize), xPaint);
      canvas.drawLine(center + Offset(crossSize, -crossSize),
          center + Offset(-crossSize, crossSize), xPaint);
    }
  }

  _drawModeCheatModeCircle(
      Canvas canvas, int currentIndex, TmtGameCircle currentCircle) {
    if (isCheatModeEnabled &&
        currentIndex == nextCircleIndex &&
        nextCircleIndex < allCircles.length &&
        !connectedCircles.contains(currentCircle)) {
      final Paint cheatPaint = Paint()
        ..color = isDarkMode ? AppColors.primaryBlueDark : AppColors.primaryBlue
        ..style = PaintingStyle.stroke
        ..strokeWidth = TmtGameVariables.CIRCLE_ERROR_CORRECT_STROKE_WIDTH;

      canvas.drawCircle(
          currentCircle.offset, TmtGameVariables.circleRadius, cheatPaint);

      final Paint fillPaint = Paint()
        ..color = (isDarkMode ? AppColors.primaryBlueDark : AppColors.primaryBlue).withAlpha(51)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
          currentCircle.offset, TmtGameVariables.circleRadius, fillPaint);
    }
  }

  _drawCircleText(Canvas canvas, TmtGameCircle currentCircle) {
    final circleTextStyle = AppTextStyle.tmtGameCircleText.copyWith(
        color: isDarkMode ? AppColors.darkText : AppColors.mainBlackText
    );

    final circleBeginEndTextStyle = AppTextStyle.tmtGameCircleBeginAndLastText.copyWith(
        color: isDarkMode ? AppColors.darkText : AppColors.mainBlackText
    );

    TextPainter numberPainter = TextPainter(
      text: TextSpan(
        text: currentCircle.text,
        style: circleTextStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    numberPainter.layout();
    numberPainter.paint(
        canvas,
        currentCircle.offset -
            Offset(numberPainter.width / 2, numberPainter.height / 2));

    var textLastOrFirst = '';
    if (currentCircle.isFirst()) {
      textLastOrFirst = TMTGame.tmtGameCircleBegin.tr;
    } else if (currentCircle == allCircles.last) {
      textLastOrFirst = TMTGame.tmtGameCircleEnd.tr;
    }

    if (currentCircle.isFirst() || currentCircle == allCircles.last) {
      TextPainter lastOrFirstPainter = TextPainter(
        text: TextSpan(
            text: textLastOrFirst,
            style: circleBeginEndTextStyle),
        textDirection: TextDirection.ltr,
      );
      lastOrFirstPainter.layout();

      // Check if the circle is too close to the top of the screen
      bool isNearTopEdge = currentCircle.offset.dy <
          TmtGameVariables.circleRadius * 2.5;

      // Position offset - either above or below the circle based on position
      Offset textPosition;
      if (isNearTopEdge) {
        // Place text below the circle if too close to top
        textPosition = currentCircle.offset +
            Offset(-lastOrFirstPainter.width / 1.8,
                TmtGameVariables.circleRadius * 1.2);
      } else {
        // Place text above the circle (original position)
        if (DeviceHelper.isTablet) {
          textPosition = currentCircle.offset -
              Offset(lastOrFirstPainter.width / 2.1,
                  TmtGameVariables.circleRadius * 2.1);
        } else {
          textPosition = currentCircle.offset -
              Offset(lastOrFirstPainter.width / 2.2,
                  TmtGameVariables.circleRadius * 2.2);
        }
      }

      lastOrFirstPainter.paint(canvas, textPosition);
    }
  }

  @override
  bool shouldRepaint(covariant TmtPainter oldDelegate) {
    return allCircles != oldDelegate.allCircles ||
        connectedCircles != oldDelegate.connectedCircles ||
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