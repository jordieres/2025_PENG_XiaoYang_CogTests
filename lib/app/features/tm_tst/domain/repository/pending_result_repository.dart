import 'package:msdtmt/app/features/tm_tst/data/model/tmt_result_metric_model.dart';
import 'package:msdtmt/app/features/tm_tst/data/model/tmt_reult_user_model.dart';
import '../../../../utils/services/net/result_data.dart';
import '../../data/model/pending_result_model.dart';

abstract class PendingResultRepository {
  Future<bool> savePendingResult(
      TmtResultModel resultModel, TmtUserModel userModel);

  Future<List<PendingResultData>> getPendingResults();

  Future<bool> deletePendingResult(PendingResultData pendingResultData);

  Future<bool> deleteAllPendingResults();

  Future<ResultData> reportTmtResults(
      Map<String, dynamic> userJson, Map<String, dynamic> resultJson);
}
