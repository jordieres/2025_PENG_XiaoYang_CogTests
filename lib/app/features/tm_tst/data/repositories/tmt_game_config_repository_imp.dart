import '../../../../utils/services/local_storage_services.dart';
import '../../domain/repository/tmt_game_config_repository.dart';

class TmtGameConfigRepositoryImpl implements TmtGameConfigRepository {
  @override
  Future<void> saveCircleNumber(int circleNumber) async {
    await LocalStorageServices.saveCircleNumber(circleNumber);
  }

  @override
  Future<int> getCircleNumber() async {
    return await LocalStorageServices.getCircleNumber();
  }
}
