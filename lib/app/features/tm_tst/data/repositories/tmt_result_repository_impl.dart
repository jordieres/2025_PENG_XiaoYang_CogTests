import 'package:msdtmt/app/utils/services/app_logger.dart';
import 'package:msdtmt/app/utils/services/net/rest_api_services.dart';
import 'package:msdtmt/app/utils/services/net/result_data.dart';

import '../../../../utils/services/net/api_error.dart';
import '../../../../utils/services/user_data_base_helper.dart';
import '../../../user/data/datasources/user_profle_data_soruce.dart';
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
      final userProfileDataSource =
          UserProfileDataSourceImpl(databaseHelper: UserDatabaseHelper());

      final currentProfile = await userProfileDataSource.getCurrentProfile();

      if (currentProfile == null) {
        return ResultData.failure(UnknownApiError('No current profile found'));
      }
      final userModel = TmtUserModel.fromUserProfile(currentProfile);

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
