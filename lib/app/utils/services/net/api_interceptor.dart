import 'package:dio/dio.dart';
import 'package:msdtmt/app/utils/services/net/rest_api_services.dart';

import '../../helpers/app_helpers.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode != 200) {
      final dioException = DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        message: 'HTTP error: ${response.statusCode}',
      );
      handler.reject(dioException);
      return;
    }

    if (response.data is Map<String, dynamic>) {
      final Map<String, dynamic> responseData = response.data;
      if (!StringHelper.equalsIgnoreCase(
          responseData[ApiConstants.statusField], ApiConstants.statusOk)) {
        String message = 'API returned an error';
        if (responseData[ApiConstants.messageField] != null) {
          message = responseData[ApiConstants.messageField];
        }
        final dioException = DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: message,
        );

        handler.reject(dioException);
        return;
      }
    }

    handler.next(response);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }
}
