abstract class TmtGameConfigRepository {
  Future<void> saveCircleNumber(int circleNumber);

  Future<int> getCircleNumber();
}
