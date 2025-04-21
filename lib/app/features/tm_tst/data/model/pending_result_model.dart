import '../../../../constans/tmt_result_model_constant.dart';

class PendingResultData {
  final Map<String, dynamic> resultModelJson;
  final Map<String, dynamic> userModelJson;
  final DateTime timestamp;

  PendingResultData({
    required this.resultModelJson,
    required this.userModelJson,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'resultModelJson': resultModelJson,
      'userModelJson': userModelJson,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory PendingResultData.fromMap(Map<String, dynamic> map) {
    return PendingResultData(
      resultModelJson: Map<String, dynamic>.from(map['resultModelJson']),
      userModelJson: Map<String, dynamic>.from(map['userModelJson']),
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  String get codeId =>
      resultModelJson[TmtResultModelConstant.CODE_ID] as String? ?? '';

  DateTime get date {
    try {
      final date =
          resultModelJson[TmtResultModelConstant.DATE_DATA] as String? ?? '';
      return DateTime.parse(date);
    } catch (e) {
      return DateTime.now();
    }
  }

  double get tmtATime {
    try {
      return resultModelJson[TmtResultModelConstant.TIME_COMPLETE_A]
              as double? ??
          0;
    } catch (e) {
      return 0.0;
    }
  }

  double get tmtBTime {
    try {
      return resultModelJson[TmtResultModelConstant.TIME_COMPLETE_B]
              as double? ??
          0;
    } catch (e) {
      return 0.0;
    }
  }
}
