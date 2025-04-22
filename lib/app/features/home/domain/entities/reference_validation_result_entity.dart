class ReferenceValidationResult {
  final bool isValid;
  final bool isUsedLocally;
  final bool isExists;
  final String? errorMessage;

  ReferenceValidationResult({
    required this.isValid,
    required this.isUsedLocally,
    required this.isExists,
    this.errorMessage,
  });
}
