import 'dart:convert';
import 'package:msdtmt/app/utils/services/app_logger.dart';
import 'package:msdtmt/app/features/tm_tst/data/model/tmt_result_metric_model.dart';
import 'package:msdtmt/app/features/tm_tst/data/model/tmt_reult_user_model.dart';
import '../../../../utils/services/local_storage_services.dart';
import '../../../../utils/services/net/rest_api_services.dart';
import '../../../../utils/services/net/result_data.dart';
import '../../domain/repository/pending_result_repository.dart';
import '../model/pending_result_model.dart';

class PendingResultRepositoryImpl implements PendingResultRepository {
  final RestApiServices _apiServices;

  static const String _loggerTag = 'PendingResultRepositoryImpl';

  PendingResultRepositoryImpl(this._apiServices);

  @override
  Future<bool> savePendingResult(
      TmtResultModel resultModel, TmtUserModel userModel) async {
    try {
      final pendingResultData = PendingResultData(
        resultModelJson: resultModel.toJson(),
        userModelJson: userModel.toJson(),
        timestamp: DateTime.now(),
      );

      List<String> pendingResults =
          await LocalStorageServices.getPendingResultList();

      pendingResults.add(jsonEncode(pendingResultData.toMap()));

      return await LocalStorageServices.savePendingResultList(pendingResults);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<PendingResultData>> getPendingResults() async {
    try {
      List<String> pendingResultsJson =
          await LocalStorageServices.getPendingResultList();
      List<PendingResultData> results = [];

      for (String jsonString in pendingResultsJson) {
        try {
          Map<String, dynamic> map = jsonDecode(jsonString);
          results.add(PendingResultData.fromMap(map));
        } catch (e) {
          AppLogger.debug(_loggerTag, e.toString());
        }
      }
      return results;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> deletePendingResult(PendingResultData pendingResultData) async {
    try {
      List<String> pendingResultsJson =
          await LocalStorageServices.getPendingResultList();
      List<String> remainingResultsJson = [];

      for (String jsonString in pendingResultsJson) {
        try {
          Map<String, dynamic> map = jsonDecode(jsonString);
          PendingResultData current = PendingResultData.fromMap(map);

          if (current.timestamp.millisecondsSinceEpoch !=
              pendingResultData.timestamp.millisecondsSinceEpoch) {
            remainingResultsJson.add(jsonString);
          }
        } catch (e) {
          remainingResultsJson.add(jsonString);
        }
      }

      return await LocalStorageServices.savePendingResultList(
          remainingResultsJson);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteAllPendingResults() async {
    try {
      return await LocalStorageServices.clearPendingResultList();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<ResultData> reportTmtResults(
      Map<String, dynamic> userJson, Map<String, dynamic> resultJson) async {
    try {
      final result = await _apiServices.reportTmtResultsWithJson(
        userJson,
        resultJson,
      );
      return result;
    } catch (e) {
      return ResultData(null, false, null);
    }
  }
}
