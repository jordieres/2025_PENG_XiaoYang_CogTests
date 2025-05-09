import 'package:msdtmt/app/features/tm_tst/domain/entities/metric/metric_static_values.dart';

import '../tmt_game/tmt_game_variable.dart';

class TmtTestTimeMetric {
  DateTime? timeStartTest;
  DateTime? timeStartTmtA;
  DateTime? timeEndTmtA;
  DateTime? timeStartTmtB;
  DateTime? timeEndTmtB;
  DateTime? timeEndTest;

  final Map<int, DateTime> tmtACircleTimestamps = {};
  final Map<int, DateTime> tmtBCircleTimestamps = {};

  double _scoreA1 = MetricStaticValues.NOT_SECTION_4_AND_5;
  double _scoreA2 = MetricStaticValues.NOT_SECTION_4_AND_5;
  double _scoreA3 = MetricStaticValues.NOT_SECTION_4_AND_5;
  double _scoreA4 = MetricStaticValues.NOT_SECTION_4_AND_5;
  double _scoreA5 = MetricStaticValues.NOT_SECTION_4_AND_5;
  double _scoreB1 = MetricStaticValues.NOT_SECTION_4_AND_5;
  double _scoreB2 = MetricStaticValues.NOT_SECTION_4_AND_5;
  double _scoreB3 = MetricStaticValues.NOT_SECTION_4_AND_5;
  double _scoreB4 = MetricStaticValues.NOT_SECTION_4_AND_5;
  double _scoreB5 = MetricStaticValues.NOT_SECTION_4_AND_5;
  bool _scoresCalculated = false;

  TmtTestTimeMetric copy() {
    TmtTestTimeMetric metric = TmtTestTimeMetric();

    if (timeStartTest != null) {
      metric.timeStartTest = DateTime.fromMillisecondsSinceEpoch(
          timeStartTest!.millisecondsSinceEpoch);
    }
    if (timeStartTmtA != null) {
      metric.timeStartTmtA = DateTime.fromMillisecondsSinceEpoch(
          timeStartTmtA!.millisecondsSinceEpoch);
    }
    if (timeEndTmtA != null) {
      metric.timeEndTmtA = DateTime.fromMillisecondsSinceEpoch(
          timeEndTmtA!.millisecondsSinceEpoch);
    }
    if (timeStartTmtB != null) {
      metric.timeStartTmtB = DateTime.fromMillisecondsSinceEpoch(
          timeStartTmtB!.millisecondsSinceEpoch);
    }
    if (timeEndTmtB != null) {
      metric.timeEndTmtB = DateTime.fromMillisecondsSinceEpoch(
          timeEndTmtB!.millisecondsSinceEpoch);
    }
    if (timeEndTest != null) {
      metric.timeEndTest = DateTime.fromMillisecondsSinceEpoch(
          timeEndTest!.millisecondsSinceEpoch);
    }

    metric.tmtACircleTimestamps.addAll(tmtACircleTimestamps);
    metric.tmtBCircleTimestamps.addAll(tmtBCircleTimestamps);

    if (_scoresCalculated) {
      metric._scoreA1 = _scoreA1;
      metric._scoreA2 = _scoreA2;
      metric._scoreA3 = _scoreA3;
      metric._scoreA4 = _scoreA4;
      metric._scoreA5 = _scoreA5;
      metric._scoreB1 = _scoreB1;
      metric._scoreB2 = _scoreB2;
      metric._scoreB3 = _scoreB3;
      metric._scoreB4 = _scoreB4;
      metric._scoreB5 = _scoreB5;
      metric._scoresCalculated = true;
    }

    return metric;
  }

  void recordTmtACircleTime(int circleNumber) {
    tmtACircleTimestamps[circleNumber] = DateTime.now();
    _scoresCalculated = false;
  }

  void recordTmtBCircleTime(int circleOrderNumber) {
    tmtBCircleTimestamps[circleOrderNumber] = DateTime.now();
    _scoresCalculated = false;
  }

  /// Rest 3 seconds because of the countdown at the beginning of the TMT test Part B.
  ///  No need to rest for the countdown at the beginning of Part A
  ///  because Part A starts before the countdown finishes.
  double calculateTimeCompleteTest() {
    return timeEndTest != null && timeStartTest != null
        ? (timeEndTest!.difference(timeStartTest!).abs().inMilliseconds /
                    MetricStaticValues.SEND_METRIC_THRESHOLD_MS)
                .toDouble() -
            TmtGameVariables.TMT_COUNTDOWN_TO_START_DURATION
        : 0.0;
  }

  double calculateTimeCompleteTmtA() {
    return timeEndTmtA != null && timeStartTmtA != null
        ? (timeEndTmtA!.difference(timeStartTmtA!).abs().inMilliseconds /
                MetricStaticValues.SEND_METRIC_THRESHOLD_MS)
            .toDouble()
        : 0.0;
  }

  double calculateTimeCompleteTmtB() {
    return timeEndTmtB != null && timeStartTmtB != null
        ? (timeEndTmtB!.difference(timeStartTmtB!).abs().inMilliseconds /
                MetricStaticValues.SEND_METRIC_THRESHOLD_MS)
            .toDouble()
        : 0.0;
  }

  void _calculateAllScores() {
    if (_scoresCalculated) return;

    if (timeStartTmtA != null) {
      if (tmtACircleTimestamps.containsKey(MetricStaticValues.SECTION_1_END)) {
        _scoreA1 = tmtACircleTimestamps[MetricStaticValues.SECTION_1_END]!
                .difference(timeStartTmtA!)
                .abs()
                .inMilliseconds /
            MetricStaticValues.SEND_METRIC_THRESHOLD_MS;
      }

      if (tmtACircleTimestamps.containsKey(MetricStaticValues.SECTION_2_END)) {
        _scoreA2 = tmtACircleTimestamps[MetricStaticValues.SECTION_1_END + 1]!
                .difference(
                    tmtACircleTimestamps[MetricStaticValues.SECTION_2_END]!)
                .abs()
                .inMilliseconds /
            MetricStaticValues.SEND_METRIC_THRESHOLD_MS;
      }

      if (tmtACircleTimestamps.containsKey(MetricStaticValues.SECTION_3_END)) {
        _scoreA3 = tmtACircleTimestamps[MetricStaticValues.SECTION_2_END + 1]!
                .difference(
                    tmtACircleTimestamps[MetricStaticValues.SECTION_3_END]!)
                .abs()
                .inMilliseconds /
            MetricStaticValues.SEND_METRIC_THRESHOLD_MS;
      }

      if (tmtACircleTimestamps.containsKey(MetricStaticValues.SECTION_4_END)) {
        _scoreA4 = tmtACircleTimestamps[MetricStaticValues.SECTION_3_END + 1]!
                .difference(
                    tmtACircleTimestamps[MetricStaticValues.SECTION_4_END]!)
                .abs()
                .inMilliseconds /
            MetricStaticValues.SEND_METRIC_THRESHOLD_MS;
      }

      if (tmtACircleTimestamps.containsKey(MetricStaticValues.SECTION_5_END)) {
        _scoreA5 = tmtACircleTimestamps[MetricStaticValues.SECTION_4_END + 1]!
                .difference(
                    tmtACircleTimestamps[MetricStaticValues.SECTION_5_END]!)
                .abs()
                .inMilliseconds /
            MetricStaticValues.SEND_METRIC_THRESHOLD_MS;
      }
    }

    if (timeStartTmtB != null) {
      if (tmtBCircleTimestamps.containsKey(MetricStaticValues.SECTION_1_END)) {
        _scoreB1 = tmtBCircleTimestamps[MetricStaticValues.SECTION_1_END]!
                .difference(timeStartTmtB!)
                .abs()
                .inMilliseconds /
            MetricStaticValues.SEND_METRIC_THRESHOLD_MS;
      }

      if (tmtBCircleTimestamps.containsKey(MetricStaticValues.SECTION_2_END)) {
        _scoreB2 = tmtBCircleTimestamps[MetricStaticValues.SECTION_1_END + 1]!
                .difference(
                    tmtBCircleTimestamps[MetricStaticValues.SECTION_2_END]!)
                .abs()
                .inMilliseconds /
            MetricStaticValues.SEND_METRIC_THRESHOLD_MS;
      }

      if (tmtBCircleTimestamps.containsKey(MetricStaticValues.SECTION_3_END)) {
        _scoreB3 = tmtBCircleTimestamps[MetricStaticValues.SECTION_2_END + 1]!
                .difference(
                    tmtBCircleTimestamps[MetricStaticValues.SECTION_3_END]!)
                .abs()
                .inMilliseconds /
            MetricStaticValues.SEND_METRIC_THRESHOLD_MS;
      }

      if (tmtBCircleTimestamps.containsKey(MetricStaticValues.SECTION_4_END)) {
        _scoreB4 = tmtBCircleTimestamps[MetricStaticValues.SECTION_3_END + 1]!
                .difference(
                    tmtBCircleTimestamps[MetricStaticValues.SECTION_4_END]!)
                .abs()
                .inMilliseconds /
            MetricStaticValues.SEND_METRIC_THRESHOLD_MS;
      }

      if (tmtBCircleTimestamps.containsKey(MetricStaticValues.SECTION_5_END)) {
        _scoreB5 = tmtBCircleTimestamps[MetricStaticValues.SECTION_4_END + 1]!
                .difference(
                    tmtBCircleTimestamps[MetricStaticValues.SECTION_5_END]!)
                .abs()
                .inMilliseconds /
            MetricStaticValues.SEND_METRIC_THRESHOLD_MS;
      }
    }
    _scoresCalculated = true;
  }

  double get scoreA1 {
    if (!_scoresCalculated) _calculateAllScores();
    return _scoreA1;
  }

  double get scoreA2 {
    if (!_scoresCalculated) _calculateAllScores();
    return _scoreA2;
  }

  double get scoreA3 {
    if (!_scoresCalculated) _calculateAllScores();
    return _scoreA3;
  }

  double get scoreA4 {
    if (!_scoresCalculated) _calculateAllScores();
    return _scoreA4;
  }

  double get scoreA5 {
    if (!_scoresCalculated) _calculateAllScores();
    return _scoreA5;
  }

  double get scoreB1 {
    if (!_scoresCalculated) _calculateAllScores();
    return _scoreB1;
  }

  double get scoreB2 {
    if (!_scoresCalculated) _calculateAllScores();
    return _scoreB2;
  }

  double get scoreB3 {
    if (!_scoresCalculated) _calculateAllScores();
    return _scoreB3;
  }

  double get scoreB4 {
    if (!_scoresCalculated) _calculateAllScores();
    return _scoreB4;
  }

  double get scoreB5 {
    if (!_scoresCalculated) _calculateAllScores();
    return _scoreB5;
  }
}
