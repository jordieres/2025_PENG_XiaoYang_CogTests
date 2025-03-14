

class TmtTestLiftMetric {



  int numberLift = 0;
  int totalLiftTime = 0;

  double calculateAverageLift() {
    return numberLift > 0 ? totalLiftTime / numberLift : 0;
  }

  void onStartLift() {
    numberLift++;
    //TODO
    // Additional implementation logic here
  }

  void onEndLift() {
    //TODO
    // Implementation logic here
  }
}