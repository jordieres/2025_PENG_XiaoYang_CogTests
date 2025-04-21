import '../../../../utils/services/net/rest_api_services.dart';
import '../../../../utils/services/net/result_data.dart';
import '../../../user/data/datasources/test_result_data_soruce.dart';
import '../../domain/repository/reference_validation_repository.dart';

class ReferenceValidationRepositoryImpl
    implements ReferenceValidationRepository {
  final TestResultLocalDataSource testResultDataSource;
  final RestApiServices apiServices;

  ReferenceValidationRepositoryImpl({
    required this.testResultDataSource,
    required this.apiServices,
  });

  @override
  Future<bool> isReferenceCodeUsedLocally(String referenceCode) async {
    return await testResultDataSource.isReferenceCodeUsed(referenceCode);
  }

  @override
  Future<ResultData> validateReferenceCodeRemotely(String referenceCode) async {
    return await apiServices.validateReferenceCode(referenceCode);
  }
}
