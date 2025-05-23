import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:msdtmt/app/features/tm_tst/data/model/tmt_result_metric_model.dart';
import 'package:msdtmt/app/features/tm_tst/data/model/tmt_reult_user_model.dart';
import 'package:msdtmt/app/utils/services/net/api_error.dart';
import '../../../../../utils/services/user_data_base_helper.dart';
import '../../../../../utils/services/work_manager_handler.dart';
import '../../../../user/data/datasources/test_result_data_soruce.dart';
import '../../../../user/data/datasources/user_profle_data_soruce.dart';
import '../../../../user/domain/entities/user_test_local_data_result.dart';
import '../../../../user/domain/repository/test_result_local_data_repository.dart';
import '../../../data/model/pending_result_model.dart';
import '../../entities/result/tmt_game_result_data.dart';
import '../../repository/pending_result_repository.dart';

class PendingResultUseCase {
  final PendingResultRepository pendingResultRepository;
  final TestResultLocalDataRepository testResultLocalDataRepositoryImpl =
      TestResultLocalDataRepositoryImpl(
    testResultDataSource: TestResultDataSourceImpl(
      databaseHelper: UserDatabaseHelper(),
    ),
  );

  PendingResultUseCase({
    required this.pendingResultRepository,
  });

  Future<bool> savePendingResult(TmtGameResultData tmtGameResultData) async {
    final userLocalDataSource =
        UserProfileDataSourceImpl(databaseHelper: UserDatabaseHelper());

    final currentProfile = await userLocalDataSource.getCurrentProfile();

    if (currentProfile == null) {
      return false;
    }
    final userModel = TmtUserModel.fromUserProfile(currentProfile);

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
          } else {
            await testResultLocalDataRepositoryImpl
                .saveTestResult(UserTestLocalDataResult(
              referenceCode: pendingResult.codeId,
              date: pendingResult.date,
              tmtATime: pendingResult.tmtATime,
              tmtBTime: pendingResult.tmtBTime,
              handUsed: pendingResult.handUsed,
            ));
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
