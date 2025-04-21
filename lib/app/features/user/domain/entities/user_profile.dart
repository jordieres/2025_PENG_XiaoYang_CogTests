class UserProfile {
  String userId = "";
  final String nickname;
  final Sex sex;
  final DateTime birthDate;
  final EducationLevel educationLevel;

  UserProfile({required this.nickname,
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


 final List<UserProfile> fakeUserProfiles = [
  UserProfile.withUserId(
      userId: "USR001",
      nickname: "Alex",
      sex: Sex.male,
      birthDate: DateTime(1995, 3, 15),
      educationLevel: EducationLevel.graduate
  ),
  UserProfile.withUserId(
      userId: "USR002",
      nickname: "Emma",
      sex: Sex.female,
      birthDate: DateTime(1988, 7, 22),
      educationLevel: EducationLevel.master
  ),
  UserProfile.withUserId(
      userId: "USR003",
      nickname: "Daniel",
      sex: Sex.male,
      birthDate: DateTime(2000, 11, 5),
      educationLevel: EducationLevel.secondary
  ),
  UserProfile.withUserId(
      userId: "USR004",
      nickname: "Sophia",
      sex: Sex.female,
      birthDate: DateTime(1992, 5, 18),
      educationLevel: EducationLevel.doctorate
  ),
  UserProfile.withUserId(
      userId: "USR005",
      nickname: "Olivia",
      sex: Sex.female,
      birthDate: DateTime(1985, 9, 30),
      educationLevel: EducationLevel.master
  ),
  UserProfile.withUserId(
      userId: "USR006",
      nickname: "James",
      sex: Sex.male,
      birthDate: DateTime(1998, 2, 14),
      educationLevel: EducationLevel.graduate
  ),
  UserProfile.withUserId(
      userId: "USR007",
      nickname: "Emily",
      sex: Sex.female,
      birthDate: DateTime(2003, 8, 7),
      educationLevel: EducationLevel.secondary
  ),
  UserProfile.withUserId(
      userId: "USR008",
      nickname: "Michael",
      sex: Sex.male,
      birthDate: DateTime(1979, 12, 25),
      educationLevel: EducationLevel.graduate
  ),
  UserProfile.withUserId(
      userId: "USR009",
      nickname: "Jessica",
      sex: Sex.female,
      birthDate: DateTime(1990, 6, 11),
      educationLevel: EducationLevel.master
  ),
  UserProfile.withUserId(
      userId: "USR010",
      nickname: "William",
      sex: Sex.male,
      birthDate: DateTime(1982, 4, 19),
      educationLevel: EducationLevel.doctorate
  ),
  UserProfile.withUserId(
      userId: "USR011",
      nickname: "Ava",
      sex: Sex.female,
      birthDate: DateTime(2001, 10, 3),
      educationLevel: EducationLevel.secondary
  ),
  UserProfile.withUserId(
      userId: "USR012",
      nickname: "Ethan",
      sex: Sex.male,
      birthDate: DateTime(1993, 1, 27),
      educationLevel: EducationLevel.graduate
  ),
  UserProfile.withUserId(
      userId: "USR013",
      nickname: "Isabella",
      sex: Sex.female,
      birthDate: DateTime(1987, 11, 9),
      educationLevel: EducationLevel.master
  ),
  UserProfile.withUserId(
      userId: "USR014",
      nickname: "Benjamin",
      sex: Sex.male,
      birthDate: DateTime(1975, 5, 22),
      educationLevel: EducationLevel.doctorate
  ),
  UserProfile.withUserId(
      userId: "USR015",
      nickname: "Mia",
      sex: Sex.female,
      birthDate: DateTime(1996, 8, 16),
      educationLevel: EducationLevel.graduate
  ),
  UserProfile.withUserId(
      userId: "USR016",
      nickname: "Jacob",
      sex: Sex.male,
      birthDate: DateTime(2002, 3, 29),
      educationLevel: EducationLevel.primary
  ),
  UserProfile.withUserId(
      userId: "USR017",
      nickname: "Charlotte",
      sex: Sex.female,
      birthDate: DateTime(1989, 7, 12),
      educationLevel: EducationLevel.master
  ),
  UserProfile.withUserId(
      userId: "USR018",
      nickname: "Noah",
      sex: Sex.male,
      birthDate: DateTime(1984, 12, 5),
      educationLevel: EducationLevel.graduate
  ),
  UserProfile.withUserId(
      userId: "USR019",
      nickname: "Amelia",
      sex: Sex.female,
      birthDate: DateTime(1997, 9, 20),
      educationLevel: EducationLevel.secondary
  ),
  UserProfile.withUserId(
      userId: "USR020",
      nickname: "Lucas",
      sex: Sex.male,
      birthDate: DateTime(1980, 4, 1),
      educationLevel: EducationLevel.doctorate
  ),
];

