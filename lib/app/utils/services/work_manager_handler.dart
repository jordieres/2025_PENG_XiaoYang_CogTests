import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import 'package:msdtmt/app/utils/services/net/rest_api_services.dart';
import '../../features/tm_tst/data/repositories/pending_result_repository_impl.dart';
import '../../features/tm_tst/domain/usecases/tmt_result/pending_result_use_case.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == WorkManagerHandler.sendResultsTask) {
        final useCase = PendingResultUseCase(
          pendingResultRepository: PendingResultRepositoryImpl(restApiServices),
        );
        bool result = await useCase.sendPendingResults();
        return result;
      }
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  });
}

class WorkManagerHandler {
  static const String sendResultsTask = "sendPendingTmtResults";

  static Future<void> initializeWorkManager() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );
  }

  static Future<void> scheduleResultsSending() async {
    await Workmanager().registerOneOffTask(
      "send_results_${DateTime.now().millisecondsSinceEpoch}",
      sendResultsTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  static Future<void> cancelWorkTask() async {
    await Workmanager().cancelByTag(sendResultsTask);
  }
}
