import '../entities/tmt_game/tmt_game_variable.dart';
import '../repository/tmt_game_config_repository.dart';

class TmtGameConfigUseCase {
  final TmtGameConfigRepository repository;

  TmtGameConfigUseCase({required this.repository});

  Future<void> saveCircleNumber(int circleNumber) async {
    await repository.saveCircleNumber(circleNumber);
  }

  Future<int> getCircleNumber() async {
    return await repository.getCircleNumber();
  }

  Future<void> loadSavedCircleNumber() async {
    final number = await getCircleNumber();
    TmtGameVariables.CIRCLE_NUMBER = number;
  }
}
