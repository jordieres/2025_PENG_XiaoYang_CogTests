
import 'package:msdtmt/app/utils/services/net/result_data.dart';
import '../../data/model/tmt_result_metric_model.dart';

abstract class TmtResultRepository {

  Future<ResultData> reportTmtResults(TmtResultModel resultModel);
}