class ReferenceValidationResult {
  final bool isValid;
  final bool isUsedLocally;
  final String? errorMessage;

  ReferenceValidationResult({
    required this.isValid,
    required this.isUsedLocally,
    this.errorMessage,
  });
}
