enum TmtGameHandUsed {
  RIGHT("D"),
  LEFT("I");

  final String value;

  const TmtGameHandUsed(this.value);

  factory TmtGameHandUsed.fromValue(String value) {
    switch (value) {
      case "D":
        return TmtGameHandUsed.RIGHT;
      case "I":
        return TmtGameHandUsed.LEFT;
      default:
        throw Exception("Invalid value for TmtGameHandUsed: $value");
    }
  }

}
