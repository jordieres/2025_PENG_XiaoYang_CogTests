
import 'package:msdtmt/app/utils/services/net/result_data.dart';
import '../../../data/model/tmt_result_metric_model.dart';
import '../../entities/result/tmt_game_result_data.dart';
import '../../repository/tmt_result_repository.dart';

class ReportTmtResultsUseCase {
  final TmtResultRepository repository;

  ReportTmtResultsUseCase(this.repository);

  Future<ResultData> execute(TmtGameResultData resultData) {
    final resultModel = TmtResultModel.fromEntity(resultData);
    return repository.reportTmtResults(resultModel);
  }
}