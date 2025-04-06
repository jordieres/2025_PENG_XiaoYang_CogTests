import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:msdtmt/app/features/tm_tst/data/model/tmt_result_metric_model.dart';
import 'package:msdtmt/app/features/tm_tst/data/model/tmt_reult_user_model.dart';
import 'package:msdtmt/app/utils/services/net/api_error.dart';
import '../../../../../utils/services/work_manager_handler.dart';
import '../../../data/model/pending_result_model.dart';
import '../../entities/result/tmt_game_result_data.dart';
import '../../repository/pending_result_repository.dart';

class PendingResultUseCase {
  final PendingResultRepository pendingResultRepository;

  PendingResultUseCase({
    required this.pendingResultRepository,
  });

  Future<bool> savePendingResult(TmtGameResultData tmtGameResultData) async {
    final userModel = TmtUserModel(
      nivelEduc: "G",
      fNacimiento: DateTime(1980, 1, 1),
      sexo: "M",
    );
    //TODO get from local storage

    bool saved = await pendingResultRepository.savePendingResult(
        TmtResultModel.fromEntity(tmtGameResultData), userModel);
    if (saved) {
      await WorkManagerHandler.scheduleResultsSending();
    }
    return saved;
  }

  ///Only send again if is network error
  Future<bool> sendPendingResults() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }

      List<PendingResultData> pendingResults =
          await pendingResultRepository.getPendingResults();

      if (pendingResults.isEmpty) {
        await _clearAllPendingResults();
        return true;
      }

      bool allSuccess = true;

      for (var pendingResult in pendingResults) {
        final result = await pendingResultRepository.reportTmtResults(
            pendingResult.userModelJson, pendingResult.resultModelJson);

        if (result.result) {
          bool deleted =
              await pendingResultRepository.deletePendingResult(pendingResult);
          if (!deleted) {
            allSuccess = false;
          }
        } else {
          if (result.error is NetworkError) {
            allSuccess = false;
          } else {
            await pendingResultRepository.deletePendingResult(pendingResult);
          }
        }
      }
      final remainingResults =
          await pendingResultRepository.getPendingResults();

      if (remainingResults.isEmpty) {
        await _clearAllPendingResults();
      }
      return allSuccess;
    } catch (e) {
      return false;
    }
  }

  Future<int> _getPendingResultCount() async {
    final results = await pendingResultRepository.getPendingResults();
    return results.length;
  }

  Future<bool> hasPendingResults() async {
    final count = await _getPendingResultCount();
    return count > 0;
  }

  Future<bool> _clearAllPendingResults() async {
    bool success = await pendingResultRepository.deleteAllPendingResults();
    if (success) {
      await WorkManagerHandler.cancelWorkTask();
    }
    return success;
  }
}
