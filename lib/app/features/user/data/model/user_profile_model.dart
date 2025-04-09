import 'package:uuid/uuid.dart';

import '../../../tm_tst/data/model/tmt_reult_user_model.dart';
import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required String nickname,
    required Sex sex,
    required DateTime birthDate,
    required EducationLevel educationLevel,
  }) : super(
          nickname: nickname,
          sex: sex,
          birthDate: birthDate,
          educationLevel: educationLevel,
        );

  UserProfileModel.withUserId({
    required String userId,
    required String nickname,
    required Sex sex,
    required DateTime birthDate,
    required EducationLevel educationLevel,
  }) : super.withUserId(
          userId: userId,
          nickname: nickname,
          sex: sex,
          birthDate: birthDate,
          educationLevel: educationLevel,
        );

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel.withUserId(
        userId: map['userId'] as String,
        nickname: map['nickname'] as String,
        sex: Sex.fromValue(map['sex'] as String),
        birthDate: DateTime.parse(map['birthDate'] as String),
        educationLevel:
            EducationLevel.fromValue(map['educationLevel'] as String));
  }




  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'nickname': nickname,
      'sex': sex.value,
      'birthDate': birthDate.toIso8601String(),
      'educationLevel': educationLevel.value,
    };
  }

  factory UserProfileModel.fromEntity(UserProfile entity) {
    return UserProfileModel(
      nickname: entity.nickname,
      sex: entity.sex,
      birthDate: entity.birthDate,
      educationLevel: entity.educationLevel,
    );
  }
}
