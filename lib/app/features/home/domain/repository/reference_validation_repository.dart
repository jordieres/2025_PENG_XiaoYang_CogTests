
import '../../../../utils/services/net/result_data.dart';

abstract class ReferenceValidationRepository {
  Future<bool> isReferenceCodeUsedLocally(String referenceCode);
  Future<ResultData> validateReferenceCodeRemotely(String referenceCode);
}