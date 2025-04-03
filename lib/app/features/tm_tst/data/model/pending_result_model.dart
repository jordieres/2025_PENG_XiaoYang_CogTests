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

  String get codeId => resultModelJson['codeid'] as String? ?? '';
}
