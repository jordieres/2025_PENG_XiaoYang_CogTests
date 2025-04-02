import 'package:get/get.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/tmt_game_init_data.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/tmt_game_result_data.dart';
import 'package:msdtmt/app/utils/services/net/api_error.dart';

import '../../../../utils/services/request_state.dart';
import '../../domain/entities/metric/tmt_metrics_controller.dart';
import '../../domain/usecases/tmt_result/report_tmt_result_use_case.dart';

class TmtResultController extends GetxController {
  final ReportTmtResultsUseCase _reportTmtResultsUseCase;

  final Rx<RequestState> state = Rx<RequestState>(RequestInitial());

  bool get isLoading => state.value is RequestLoading;

  bool get isSuccess => state.value is RequestSuccess;

  bool get hasError => state.value is RequestError;

  String? get errorMessage =>
      state.value is RequestError ? (state.value as RequestError).message : '';

  TmtResultController(this._reportTmtResultsUseCase);

  Future<void> reportResults(
      TmtMetricsController controller, TmtGameInitData tmtGameInitData) async {
    try {
      state.value = RequestLoading();
      TmtGameResultData resultData =
          await TmtGameResultData.fromMetricsController(
              controller, tmtGameInitData);
      final result = await _reportTmtResultsUseCase.execute(resultData);

      if (result.result) {
        state.value = RequestSuccess(result.data);
      } else {
        state.value = RequestError(result.error);
      }
    } catch (e) {
      final error = UnknownApiError(e.toString());
      state.value = RequestError(error);
    }
  }

  void resetState() {
    state.update((val) => RequestInitial());
  }
}
