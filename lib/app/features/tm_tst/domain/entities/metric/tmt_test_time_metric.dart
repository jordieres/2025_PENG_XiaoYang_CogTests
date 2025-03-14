// TmtTestTime class
class TmtTestTimeMetric {
  DateTime? timeStartTest;
  DateTime? timeStartTmtA;
  DateTime? timeEndTmtA;
  DateTime? timeStartTmtB;
  DateTime? timeEndTmtB;
  DateTime? timeEndTest;

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
