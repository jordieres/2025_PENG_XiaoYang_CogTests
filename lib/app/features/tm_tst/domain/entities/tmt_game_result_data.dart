import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import 'metric/tmt_metrics_controller.dart';

class TmtGameResultData {
  final double averageLift; // in seconds
  final double averagePause; // in seconds
  final double averageRateBeforeLetters;
  final double averageRateBeforeNumbers;
  final double averageRateBetweenCircles;
  final double averageRateInsideCircles;
  final double averageTimeBeforeLetters; // in seconds
  final double averageTimeBeforeNumbers; // in seconds
  final double averageTimeBetweenCircles; // in seconds
  final double averageTimeInsideCircles; // in seconds
  final double averageTotalPressure;
  final double averageTotalSize;
  final String codeId;
  final DateTime dateData;
  final int numberErrors;
  final int numberErrorsA;
  final int numberErrorsB;
  final int numberLifts;
  final int numberPauses;
  final int numCirc;
  final double timeComplete; // in seconds
  final double timeCompleteA; // in seconds
  final double timeCompleteB; // in seconds
  final String deviceModel;

  final double scoreA;
  final double scoreA1;
  final double scoreA2;
  final double scoreA3;
  final double scoreA4; // section4 is optional to 15 circles test
  final double scoreA5; // section5 is optional to 15 circles test

  final double scoreB;
  final double scoreB1;
  final double scoreB2;
  final double scoreB3;
  final double scoreB4; // section4 is optional to 15 circles test
  final double scoreB5; // section5 is optional to 15 circles test

  TmtGameResultData({
    required this.averageLift,
    required this.averagePause,
    required this.averageRateBeforeLetters,
    required this.averageRateBeforeNumbers,
    required this.averageRateBetweenCircles,
    required this.averageRateInsideCircles,
    required this.averageTimeBeforeLetters,
    required this.averageTimeBeforeNumbers,
    required this.averageTimeBetweenCircles,
    required this.averageTimeInsideCircles,
    required this.averageTotalPressure,
    required this.averageTotalSize,
    required this.codeId,
    required this.dateData,
    required this.numberErrors,
    required this.numberErrorsA,
    required this.numberErrorsB,
    required this.numberLifts,
    required this.numberPauses,
    required this.numCirc,
    required this.timeComplete,
    required this.timeCompleteA,
    required this.timeCompleteB,
    required this.deviceModel,
    required this.scoreA,
    required this.scoreA1,
    required this.scoreA2,
    required this.scoreA3,
    required this.scoreA4,
    required this.scoreA5,
    required this.scoreB,
    required this.scoreB1,
    required this.scoreB2,
    required this.scoreB3,
    required this.scoreB4,
    required this.scoreB5,
  });

  static Future<TmtGameResultData> fromMetricsController(
    TmtMetricsController controller, {
    String codeId = "", //TODO add
  }) async {
    String deviceModel = await _getDeviceModel();

    double scoreA1 = controller.testTimeMetrics.scoreA1;
    double scoreA2 = controller.testTimeMetrics.scoreA2;
    double scoreA3 = controller.testTimeMetrics.scoreA3;
    double scoreA4 = controller.testTimeMetrics.scoreA4;
    double scoreA5 = controller.testTimeMetrics.scoreA5;

    double scoreB1 = controller.testTimeMetrics.scoreB1;
    double scoreB2 = controller.testTimeMetrics.scoreB2;
    double scoreB3 = controller.testTimeMetrics.scoreB3;
    double scoreB4 = controller.testTimeMetrics.scoreB4;
    double scoreB5 = controller.testTimeMetrics.scoreB5;

    return TmtGameResultData(
      averageLift: controller.testLiftMetric.calculateAverageLift(),
      averagePause: controller.testPauseMetric.calculateAveragePause(),
      averageRateBeforeLetters:
          controller.bMetrics.calculateAverageRateBeforeLetters(),
      averageRateBeforeNumbers:
          controller.bMetrics.calculateAverageRateBeforeNumbers(),
      averageRateBetweenCircles:
          controller.circleMetrics.calculateAverageRateBetweenCircles(),
      averageRateInsideCircles:
          controller.circleMetrics.calculateAverageRateInsideCircles(),
      averageTimeBeforeLetters:
          controller.bMetrics.calculateAverageTimeBeforeLetters(),
      averageTimeBeforeNumbers:
          controller.bMetrics.calculateAverageTimeBeforeNumbers(),
      averageTimeBetweenCircles:
          controller.circleMetrics.calculateAverageTimeBetweenCircles(),
      averageTimeInsideCircles:
          controller.circleMetrics.calculateAverageTimeInsideCircles(),
      averageTotalPressure:
          controller.pressureSizeMetric.calculateAverageTotalPressure(),
      averageTotalSize:
          controller.pressureSizeMetric.calculateAverageTotalSize(),
      codeId: codeId,
      dateData: DateTime.now(),
      numberErrors: controller.numberError,
      numberErrorsA: controller.numberErrorA,
      numberErrorsB: controller.numberErrorB,
      numberLifts: controller.testLiftMetric.numberLift,
      numberPauses: controller.testPauseMetric.numberPause,
      numCirc: controller.circles.length,
      timeComplete: controller.testTimeMetrics.calculateTimeCompleteTest(),
      timeCompleteA: controller.testTimeMetrics.calculateTimeCompleteTmtA(),
      timeCompleteB: controller.testTimeMetrics.calculateTimeCompleteTmtB(),
      deviceModel: deviceModel,
      scoreA: controller.testTimeMetrics.calculateTimeCompleteTmtA(),
      scoreA1: scoreA1,
      scoreA2: scoreA2,
      scoreA3: scoreA3,
      scoreA4: scoreA4,
      scoreA5: scoreA5,
      scoreB: controller.testTimeMetrics.calculateTimeCompleteTmtB(),
      scoreB1: scoreB1,
      scoreB2: scoreB2,
      scoreB3: scoreB3,
      scoreB4: scoreB4,
      scoreB5: scoreB5,
    );
  }

  static Future<String> _getDeviceModel() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return "${androidInfo.brand}_${androidInfo.model}";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return "${iosInfo.name}_${iosInfo.model}";
      }
    } catch (e) {
      return "unknown_device";
    }
    return "unknown_device";
  }
}
