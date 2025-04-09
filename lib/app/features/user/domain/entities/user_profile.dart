class UserProfile {
  String userId = "";
  final String nickname;
  final Sex sex;
  final DateTime birthDate;
  final EducationLevel educationLevel;

  UserProfile(
      {required this.nickname,
      required this.sex,
      required this.birthDate,
      required this.educationLevel});

  UserProfile.withUserId({
    required this.userId,
    required this.nickname,
    required this.sex,
    required this.birthDate,
    required this.educationLevel,
  });
}

enum Sex {
  male("M"),
  female("F");

  final String value;

  const Sex(this.value);

  factory Sex.fromValue(String value) {
    switch (value) {
      case "M":
        return Sex.male;
      case "F":
        return Sex.female;
      default:
        return Sex.male;
    }
  }
}

enum EducationLevel {
  primary("1"),
  secondary("2"),
  graduate("G"),
  master("M"),
  doctorate("D");

  final String value;

  const EducationLevel(this.value);

  factory EducationLevel.fromValue(String value) {
    switch (value) {
      case "1":
        return EducationLevel.primary;
      case "2":
        return EducationLevel.secondary;
      case "G":
        return EducationLevel.graduate;
      case "M":
        return EducationLevel.master;
      case "D":
        return EducationLevel.doctorate;
      default:
        return EducationLevel.primary;
    }
  }
}
