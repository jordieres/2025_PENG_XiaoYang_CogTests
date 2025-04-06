
import '../../domain/entities/user_test_result.dart';

class UserTestResultModel extends UserTestResult {
  UserTestResultModel({
    required String referenceCode,
    required DateTime date,
    required double tmtATime,
    required double tmtBTime,
  }) : super(
    referenceCode: referenceCode,
    date: date,
    tmtATime: tmtATime,
    tmtBTime: tmtBTime,
  );

  factory UserTestResultModel.fromMap(Map<String, dynamic> map) {
    return UserTestResultModel(
      referenceCode: map['referenceCode'] as String,
      date: DateTime.parse(map['date'] as String),
      tmtATime: map['tmtATime'] as double,
      tmtBTime: map['tmtBTime'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'referenceCode': referenceCode,
      'date': date.toIso8601String(),
      'tmtATime': tmtATime,
      'tmtBTime': tmtBTime,
    };
  }

  factory UserTestResultModel.fromEntity(UserTestResult entity) {
    return UserTestResultModel(
      referenceCode: entity.referenceCode,
      date: entity.date,
      tmtATime: entity.tmtATime,
      tmtBTime: entity.tmtBTime,
    );
  }
}