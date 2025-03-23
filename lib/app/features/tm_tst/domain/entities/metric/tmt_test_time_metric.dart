// TmtTestTime class
class TmtTestTimeMetric {
  DateTime? timeStartTest;
  DateTime? timeStartTmtA;
  DateTime? timeEndTmtA;
  DateTime? timeStartTmtB;
  DateTime? timeEndTmtB;
  DateTime? timeEndTest;

  TmtTestTimeMetric copy() {
    TmtTestTimeMetric metric = TmtTestTimeMetric();

    if (timeStartTest != null) {
      metric.timeStartTest =
          DateTime.fromMillisecondsSinceEpoch(timeStartTest!.millisecondsSinceEpoch);
    }

    if (timeStartTmtA != null) {
      metric.timeStartTmtA =
          DateTime.fromMillisecondsSinceEpoch(timeStartTmtA!.millisecondsSinceEpoch);
    }

    if (timeEndTmtA != null) {
      metric.timeEndTmtA =
          DateTime.fromMillisecondsSinceEpoch(timeEndTmtA!.millisecondsSinceEpoch);
    }

    if (timeStartTmtB != null) {
      metric.timeStartTmtB =
          DateTime.fromMillisecondsSinceEpoch(timeStartTmtB!.millisecondsSinceEpoch);
    }

    if (timeEndTmtB != null) {
      metric.timeEndTmtB =
          DateTime.fromMillisecondsSinceEpoch(timeEndTmtB!.millisecondsSinceEpoch);
    }

    if (timeEndTest != null) {
      metric.timeEndTest =
          DateTime.fromMillisecondsSinceEpoch(timeEndTest!.millisecondsSinceEpoch);
    }

    return metric;
  }


  Duration calculateTimeCompleteTest() {
    return timeEndTest != null && timeStartTest != null
        ? timeEndTest!.difference(timeStartTest!)
        : Duration.zero;
  }

  Duration calculateTimeCompleteTmtA() {
    return timeEndTmtA != null && timeStartTmtA != null
        ? timeEndTmtA!.difference(timeStartTmtA!)
        : Duration.zero;
  }

  Duration calculateTimeCompleteTmtB() {
    return timeEndTmtB != null && timeStartTmtB != null
        ? timeEndTmtB!.difference(timeStartTmtB!)
        : Duration.zero;
  }
}
