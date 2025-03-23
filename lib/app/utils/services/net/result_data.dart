import 'dart:convert';

class ResultData {
  dynamic data;
  bool result;
  int? code;
  dynamic headers;

  ResultData(this.data, this.result, this.code, {this.headers});

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
    return 'ResultData {\n  result: $result,\n  code: $code,\n  data: $dataStr\n}';
  }
}
