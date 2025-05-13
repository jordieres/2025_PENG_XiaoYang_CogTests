import '../../../../utils/services/net/rest_api_services.dart';

enum HandsUsed {
  NONE, // No hands used yet
  LEFT, // Left hand used
  RIGHT, // Right hand used
  BOTH; // Both hands used (I and D)

  static HandsUsed fromList(List<dynamic>? hands) {
    if (hands == null || hands.isEmpty) return HandsUsed.NONE;

    if (hands.contains(ApiConstants.referenceCodeHandLeft) &&
        hands.contains(ApiConstants.referenceCodeHandRight)) {
      return HandsUsed.BOTH;
    } else if (hands.contains(ApiConstants.referenceCodeHandLeft)) {
      return HandsUsed.LEFT;
    } else if (hands.contains(ApiConstants.referenceCodeHandRight)) {
      return HandsUsed.RIGHT;
    }

    return HandsUsed.NONE;
  }
}

class ReferenceValidationResult {
  static const  MAX_NUMBER_EXISTS = 2;

  final bool isValid;
  final bool isUsedLocally;
  final int numberExists;
  final HandsUsed handsUsed;
  final String? errorMessage;

  ReferenceValidationResult({
    required this.isValid,
    required this.isUsedLocally,
    required this.numberExists,
    this.handsUsed = HandsUsed.NONE,
    this.errorMessage,
  });

  canUse() {
    return numberExists >= MAX_NUMBER_EXISTS || handsUsed == HandsUsed.BOTH;
  }
}
