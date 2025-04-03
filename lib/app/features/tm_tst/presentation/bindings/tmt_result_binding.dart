import 'package:get/get.dart';
import 'package:msdtmt/app/features/tm_tst/data/repositories/pending_result_repository_impl.dart';
import 'package:msdtmt/app/features/tm_tst/data/repositories/tmt_result_repository_impl.dart';
import 'package:msdtmt/app/utils/services/net/rest_api_services.dart';
import '../../domain/repository/tmt_result_repository.dart';
import '../../domain/usecases/tmt_result/pending_result_use_case.dart';
import '../../domain/usecases/tmt_result/report_tmt_result_use_case.dart';
import '../controllers/tmt_result_controller.dart';

class TmtResultBinding extends Bindings {

  @override
  void dependencies() {
    // Repository
    Get.lazyPut<TmtResultRepository>(
      () => TmtResultRepositoryImpl(restApiServices),
    );

    Get.lazyPut(
      () => PendingResultUseCase(
          pendingResultRepository:
              PendingResultRepositoryImpl(restApiServices)),
    );

    // Use Case
    Get.lazyPut(() => ReportTmtResultsUseCase(
          Get.find<TmtResultRepository>(),
          Get.find<PendingResultUseCase>(),
        ));

    // Controller
    Get.put(TmtResultController(
      Get.find<ReportTmtResultsUseCase>(),
    ));
  }
}
