import 'package:get/get.dart';
import '../../data/repositories/tmt_game_config_repository_imp.dart';
import '../../domain/repository/tmt_game_config_repository.dart';
import '../../domain/usecases/tmt_game_config_use_case.dart';

class TmtGameConfigBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TmtGameConfigRepository>(
      () => TmtGameConfigRepositoryImpl(),
    );

    Get.lazyPut<TmtGameConfigUseCase>(
      () => TmtGameConfigUseCase(
        repository: Get.find<TmtGameConfigRepository>(),
      ),
    );
  }
}
