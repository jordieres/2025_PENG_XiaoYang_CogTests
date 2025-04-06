import 'package:msdtmt/app/features/tm_tst/data/model/tmt_result_metric_model.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/result/tmt_game_result_data.dart';
import 'package:msdtmt/app/features/tm_tst/domain/repository/tmt_result_repository.dart';
import 'package:msdtmt/app/features/tm_tst/domain/usecases/tmt_result/pending_result_use_case.dart';
import 'package:msdtmt/app/utils/services/net/result_data.dart';

import '../../../../../utils/services/net/api_error.dart';

class ReportTmtResultsUseCase {

  final TmtResultRepository repository;
  final PendingResultUseCase pendingResultUseCase;

  ReportTmtResultsUseCase(this.repository,  this.pendingResultUseCase);

  Future<ResultData> execute(TmtGameResultData resultData) async {
    try {
      final resultModel = TmtResultModel.fromEntity(resultData);
      final result = await repository.reportTmtResults(resultModel);
      if (!result.result) {
        if(result.error is NetworkError){
          await pendingResultUseCase.savePendingResult(resultData);
        }
      }
      return result;
    } catch (e) {
        await pendingResultUseCase.savePendingResult(resultData);
      return ResultData(null, false, null);
    }
  }
}