import 'package:msdtmt/app/utils/services/app_logger.dart';
import 'package:msdtmt/app/utils/services/net/rest_api_services.dart';
import 'package:msdtmt/app/utils/services/net/result_data.dart';

import '../../domain/entities/result/tmt_user_data.dart';
import '../../domain/repository/tmt_result_repository.dart';
import '../model/tmt_result_metric_model.dart';
import '../model/tmt_reult_user_model.dart';

class TmtResultRepositoryImpl implements TmtResultRepository {
  final RestApiServices _apiServices;

  static const String _loggerName = 'TmtResultRepositoryImpl';

  TmtResultRepositoryImpl(this._apiServices);

  @override
  Future<ResultData> reportTmtResults(TmtResultModel resultModel) async {
    try {
      TmtUserData userData = TmtUserData(
        nivelEduc: "G",
        sexo: "M",
        fNacimiento: DateTime(1980, 1, 1),
      );
      //TODO get Userdata from local storage

      final userModel = TmtUserModel.fromEntity(userData);

      final result = await _apiServices.reportTmtResults(
        userModel,
        resultModel,
      );
      return result;
    } catch (e, stackTrace) {
      AppLogger.severe(
          _loggerName, 'Error reporting TMT results', e, stackTrace);
      return ResultData(null, false, null);
    }
  }

}
