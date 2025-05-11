class UserTestLocalDataResult {
  final String referenceCode;
  final DateTime date;
  final double tmtATime;
  final double tmtBTime;
  final String handUsed;
  final String? resultId;

  UserTestLocalDataResult({
    required this.referenceCode,
    required this.date,
    required this.tmtATime,
    required this.tmtBTime,
    required this.handUsed,
    this.resultId,
  });
}
