import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import 'metric/metric_static_values.dart';
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
  final String score;
  final double timeComplete; // in seconds
  final double timeCompleteA; // in seconds
  final double timeCompleteB; // in seconds
  final String deviceModel;

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
    required this.score,
    required this.timeComplete,
    required this.timeCompleteA,
    required this.timeCompleteB,
    required this.deviceModel,
  });

  static Future<TmtGameResultData> fromMetricsController(
    TmtMetricsController controller, {
    String codeId = "", //TODO parse TMT test code
    String score = "38", // TODO calculate score
  }) async {
    // Get device model information
    String deviceModel = await _getDeviceModel();

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
          controller.bMetrics.calculateAverageTimeBeforeNumbers() ,
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
      score: score,
      timeComplete: controller.testTimeMetrics
              .calculateTimeCompleteTest()
              .inMilliseconds /
          MetricStaticValues.SEND_METRIC_THRESHOLD_MS,
      timeCompleteA: controller.testTimeMetrics
              .calculateTimeCompleteTmtA()
              .inMilliseconds /
          MetricStaticValues.SEND_METRIC_THRESHOLD_MS,
      timeCompleteB: controller.testTimeMetrics
              .calculateTimeCompleteTmtB()
              .inMilliseconds /
          MetricStaticValues.SEND_METRIC_THRESHOLD_MS,
      deviceModel: deviceModel,
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
