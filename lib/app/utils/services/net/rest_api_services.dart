import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:msdtmt/app/utils/services/net/result_data.dart';
import '../../../constans/app_constants.dart';
import '../../../features/tm_tst/data/model/tmt_result_metric_model.dart';
import '../../../features/tm_tst/data/model/tmt_reult_user_model.dart';
import 'api_error.dart';
import 'api_interceptor.dart';

part 'api_constants.dart';

class RestApiServices {
  static final RestApiServices _restApiServices = RestApiServices._internal();

  factory RestApiServices() {
    return _restApiServices;
  }

  late final Dio _dio;
  static const String _loggerTag = 'RestApiServices';

  RestApiServices._internal() {
    _dio = Dio();

    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.contentType = Headers.formUrlEncodedContentType;

    _dio.interceptors.add(ApiInterceptor());

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
  }

  Future<ResultData> validateReferenceCode(String codeId) async {
    final data = {
      ApiConstants.codeIdField: codeId,
    };

    try {
      final response = await _dio.post(
        ApiPath.validationCode,
        data: data,
      );

      return ResultData.success(
        response.data,
        code: response.statusCode,
        headers: response.headers.map,
      );
    } on DioException catch (e) {
      final ApiError apiError = _createApiErrorFromDioException(e);

      return ResultData.failure(
        apiError,
        data: e.response?.data,
        code: e.response?.statusCode,
        headers: e.response?.headers?.map,
      );
    } catch (e) {
      final error = UnknownApiError(e.toString());
      return ResultData.failure(error);
    }
  }

  Future<ResultData> reportTmtResults(
      String codeId, TmtUserModel userModel, TmtResultModel resultModel) async {
    try {
      final userJson = userModel.toJson();
      final resultJson = resultModel.toJson();

      final data = {
        ApiConstants.codeIdField: codeId,
        ...userJson,
        ...resultJson,
      };

      final response = await _dio.post(
        ApiPath.reportTmtResult,
        data: data,
      );
      return ResultData.success(
        response.data,
        code: response.statusCode,
        headers: response.headers.map,
      );
    } on DioException catch (e) {
      final ApiError apiError = _createApiErrorFromDioException(e);
      return ResultData.failure(
        apiError,
        data: e.response?.data,
        code: e.response?.statusCode,
        headers: e.response?.headers.map,
      );
    } catch (e) {
      final error = UnknownApiError(e.toString());
      return ResultData.failure(error);
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

      return ResultData.success(
        response.data,
        code: response.statusCode,
        headers: response.headers.map,
      );
    } on DioException catch (e) {
      final ApiError apiError = _createApiErrorFromDioException(e);

      return ResultData.failure(
        apiError,
        data: e.response?.data,
        code: e.response?.statusCode,
        headers: e.response?.headers?.map,
      );
    } catch (e) {
      final error = UnknownApiError(e.toString());
      return ResultData.failure(error);
    }
  }

  ApiError _createApiErrorFromDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return NetworkError('Connection timeout. Please check your network connection.');
    } else if (e.type == DioExceptionType.connectionError) {
      return NetworkError('No internet connection. Please check your network.');
    } else if (e.type == DioExceptionType.badResponse) {
      final int? statusCode = e.response?.statusCode;
      String message = e.message ?? 'Server error occurred';

      if (e.response?.data is Map) {
        final Map<String, dynamic> responseData = e.response!.data;
        if (responseData[ApiConstants.messageField] != null) {
          message = responseData[ApiConstants.messageField];
        }
      }
      return ApiError.create(
        e.response?.data,
        statusCode: statusCode,
        message: message,
      );
    } else {
      return UnknownApiError('An unexpected error occurred: ${e.message}');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

final RestApiServices restApiServices = RestApiServices();