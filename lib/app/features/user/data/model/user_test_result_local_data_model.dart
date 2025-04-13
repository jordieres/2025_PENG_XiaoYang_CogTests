
import '../../domain/entities/user_test_local_data_result.dart';

class UserTestResultLocalDataModel extends UserTestLocalDataResult {
  UserTestResultLocalDataModel({
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

  factory UserTestResultLocalDataModel.fromMap(Map<String, dynamic> map) {
    return UserTestResultLocalDataModel(
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

  factory UserTestResultLocalDataModel.fromEntity(UserTestLocalDataResult entity) {
    return UserTestResultLocalDataModel(
      referenceCode: entity.referenceCode,
      date: entity.date,
      tmtATime: entity.tmtATime,
      tmtBTime: entity.tmtBTime,
    );
  }
}