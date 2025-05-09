import '../../../../constans/database_constants.dart';
import '../../domain/entities/user_test_local_data_result.dart';

class UserTestResultLocalDataModel extends UserTestLocalDataResult {
  UserTestResultLocalDataModel({
    required super.referenceCode,
    required super.date,
    required super.tmtATime,
    required super.tmtBTime,
    required super.handUsed,
    super.resultId,
  });

  factory UserTestResultLocalDataModel.fromMap(Map<String, dynamic> map) {
    return UserTestResultLocalDataModel(
      resultId: map[DatabaseConstants.resultIdColumn] as String,
      referenceCode: map[DatabaseConstants.referenceCodeColumn] as String,
      date: DateTime.parse(map[DatabaseConstants.dateColumn] as String),
      tmtATime: map[DatabaseConstants.tmtATimeColumn] as double,
      tmtBTime: map[DatabaseConstants.tmtBTimeColumn] as double,
      handUsed: map[DatabaseConstants.handUsedColumn] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.referenceCodeColumn: referenceCode,
      DatabaseConstants.dateColumn: date.toIso8601String(),
      DatabaseConstants.tmtATimeColumn: tmtATime,
      DatabaseConstants.tmtBTimeColumn: tmtBTime,
      DatabaseConstants.handUsedColumn: handUsed,
    };
  }

  factory UserTestResultLocalDataModel.fromEntity(
      UserTestLocalDataResult entity) {
    return UserTestResultLocalDataModel(
      resultId: entity.resultId,
      referenceCode: entity.referenceCode,
      date: entity.date,
      tmtATime: entity.tmtATime,
      tmtBTime: entity.tmtBTime,
      handUsed: entity.handUsed,
    );
  }
}
