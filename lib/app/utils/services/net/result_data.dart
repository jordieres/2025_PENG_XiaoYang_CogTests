
import 'dart:convert';

import 'api_error.dart';

class ResultData {
  final dynamic data;
  final bool result;
  final int? code;
  final dynamic headers;
  final ApiError? error;

  ResultData(this.data, this.result, this.code, {this.headers, this.error});

  factory ResultData.success(dynamic data, {int? code, dynamic headers}) {
    return ResultData(data, true, code, headers: headers);
  }

  factory ResultData.failure(ApiError error, {dynamic data, int? code, dynamic headers}) {
    return ResultData(data, false, code, headers: headers, error: error);
  }

  bool get hasError => !result || error != null;

  String get errorMessage => error?.message ?? 'Unknown error';

  @override
  String toString() {
    String dataStr;
    try {
      if (data != null) {
        dataStr = const JsonEncoder.withIndent('  ').convert(data);
      } else {
        dataStr = 'null';
      }
    } catch (e) {
      dataStr = data.toString();
    }

    String errorStr = error != null
        ? '\n  error: ${error!.message} (${error!.statusCode})'
        : '';

    return 'ResultData {\n  result: $result,\n  code: $code,$errorStr\n  data: $dataStr\n}';
  }
}