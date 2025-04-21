import '../../../../constans/database_constants.dart';
import '../../domain/entities/user_test_local_data_result.dart';

class UserTestResultLocalDataModel extends UserTestLocalDataResult {
  UserTestResultLocalDataModel({
    required super.referenceCode,
    required super.date,
    required super.tmtATime,
    required super.tmtBTime,
  });

  factory UserTestResultLocalDataModel.fromMap(Map<String, dynamic> map) {
    return UserTestResultLocalDataModel(
      referenceCode: map[DatabaseConstants.referenceCodeColumn] as String,
      date: DateTime.parse(map[DatabaseConstants.dateColumn] as String),
      tmtATime: map[DatabaseConstants.tmtATimeColumn] as double,
      tmtBTime: map[DatabaseConstants.tmtBTimeColumn] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.referenceCodeColumn: referenceCode,
      DatabaseConstants.dateColumn: date.toIso8601String(),
      DatabaseConstants.tmtATimeColumn: tmtATime,
      DatabaseConstants.tmtBTimeColumn: tmtBTime,
    };
  }

  factory UserTestResultLocalDataModel.fromEntity(
      UserTestLocalDataResult entity) {
    return UserTestResultLocalDataModel(
      referenceCode: entity.referenceCode,
      date: entity.date,
      tmtATime: entity.tmtATime,
      tmtBTime: entity.tmtBTime,
    );
  }
}
