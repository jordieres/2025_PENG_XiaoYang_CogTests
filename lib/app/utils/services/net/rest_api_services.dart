import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/tmt_game_result_data.dart';
import 'package:msdtmt/app/features/tm_tst/domain/entities/tmt_user_data.dart';
import 'package:msdtmt/app/utils/services/app_logger.dart';
import 'package:msdtmt/app/utils/services/net/result_data.dart';
import '../../../constans/app_constants.dart';

part 'api_constants.dart';

class RestApiServices {
  static final RestApiServices _restApiServices = RestApiServices._internal();

  factory RestApiServices() {
    return _restApiServices;
  }

  RestApiServices._internal() {
    _dio = Dio();

    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.contentType = Headers.formUrlEncodedContentType;

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
  }

  late final Dio _dio;

  Future<ResultData> validateReferenceCode(String codeId) async {
    try {
      final data = {
        ApiConstants.codeIdField: codeId,
      };

      final response = await _dio.post(
        ApiPath.validationCode,
        data: data,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return ResultData(
          responseData,
          true,
          response.statusCode,
          headers: response.headers.map,
        );
      }

      return ResultData(null, false, response.statusCode);
    } catch (e) {
      AppLogger.debug(ApiConstants.validateReferenceCodeTag, e.toString());
      return ResultData(null, false, null);
    }
  }

  Future<ResultData> reportTmtResults(
      String codeId, TmtUserData userData, TmtGameResultData resultData) async {
    try {
      final String birthDate = _formatDate(userData.fNacimiento);
      final String testDate = _formatDate(resultData.dateData);

      final data = {
        ApiConstants.codeIdField: codeId,
        ApiConstants.birthDateField: birthDate,
        ApiConstants.sexField: userData.sexo,
        ApiConstants.educLevelField: userData.nivelEduc,
        ApiConstants.handField: userData.mano,
        ApiConstants.numCircField: resultData.numCirc,
        ApiConstants.timeCompleteField: resultData.timeComplete,
        ApiConstants.numberErrorsField: resultData.numberErrors,
        ApiConstants.averagePauseField: resultData.averagePause,
        ApiConstants.averageLiftField: resultData.averageLift,
        ApiConstants.averageRateBetweenCirclesField:
            resultData.averageRateBetweenCircles,
        ApiConstants.averageRateInsideCirclesField:
            resultData.averageRateInsideCircles,
        ApiConstants.averageTimeBetweenCirclesField:
            resultData.averageTimeBetweenCircles,
        ApiConstants.averageTimeInsideCirclesField:
            resultData.averageTimeInsideCircles,
        ApiConstants.averageRateBeforeLettersField:
            resultData.averageRateBeforeLetters,
        ApiConstants.averageRateBeforeNumbersField:
            resultData.averageRateBeforeNumbers,
        ApiConstants.averageTimeBeforeLettersField:
            resultData.averageTimeBeforeLetters,
        ApiConstants.averageTimeBeforeNumbersField:
            resultData.averageTimeBeforeNumbers,
        ApiConstants.numberPausesField: resultData.numberPauses,
        ApiConstants.numberLiftsField: resultData.numberLifts,
        ApiConstants.averageTotalPressureField: resultData.averageTotalPressure,
        ApiConstants.averageTotalSizeField: resultData.averageTotalSize,
        ApiConstants.dateDataField: testDate,
        ApiConstants.scoreField: resultData.score,
        ApiConstants.numberErrorAField: resultData.numberErrorA,
        ApiConstants.numberErrorBField: resultData.numberErrorB,
        ApiConstants.timeCompleteAField: resultData.timeCompleteA,
        ApiConstants.timeCompleteBField: resultData.timeCompleteB,
        ApiConstants.deviceModelField: resultData.deviceModel,
      };

      final response = await _dio.post(
        ApiPath.reportTmtResult,
        data: data,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final bool success =
            responseData[ApiConstants.statusField] == ApiConstants.statusOk;

        return ResultData(
          responseData,
          success,
          response.statusCode,
          headers: response.headers.map,
        );
      }

      return ResultData(null, false, response.statusCode);
    } catch (e) {
      AppLogger.debug(ApiConstants.reportTmtResultsTag, e.toString());
      return ResultData(null, false, null);
    }
  }

  Future<ResultData> listTestResults(String codeId, DateTime dateData) async {
    try {
      final data = {
        ApiConstants.codeIdField: codeId,
        ApiConstants.dateDataField: _formatDate(dateData),
      };

      final response = await _dio.post(
        ApiPath.listTmtMetric,
        data: data,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final bool success =
            responseData[ApiConstants.statusField] == ApiConstants.statusOk;
        List<Map<String, dynamic>> results = [];

        if (success && responseData[ApiConstants.dataField] != null) {
          results = List<Map<String, dynamic>>.from(
              responseData[ApiConstants.dataField]);
        }

        return ResultData(
          results,
          success,
          response.statusCode,
          headers: response.headers.map,
        );
      }

      return ResultData([], false, response.statusCode);
    } catch (e) {
      AppLogger.debug(ApiConstants.listTestResultsTag, e.toString());
      return ResultData([], false, null);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}${ApiConstants.dateFormatSeparator}${date.month.toString().padLeft(ApiConstants.padWidth, ApiConstants.padding)}${ApiConstants.dateFormatSeparator}${date.day.toString().padLeft(ApiConstants.padWidth, ApiConstants.padding)}';
  }
}

final RestApiServices restApiServices = RestApiServices();
