import 'package:get/get.dart';
import '../../../../utils/services/user_data_base_helper.dart';
import '../../../user/data/datasources/test_result_data_soruce.dart';
import '../../domain/repository/reference_validation_repository.dart';
import '../../domain/usecases/validate_reference_code_use_case.dart';
import '../../data/repositories/reference_validation_repository_impl.dart';
import '../../../../utils/services/net/rest_api_services.dart';
import '../controllers/reference_code_controller.dart';

class ReferenceValidationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserDatabaseHelper());
    Get.lazyPut(() => RestApiServices());

    Get.lazyPut<TestResultDataSourceImpl>(
      () => TestResultDataSourceImpl(
        databaseHelper: Get.find<UserDatabaseHelper>(),
      ),
    );

    Get.lazyPut<ReferenceValidationRepository>(
      () => ReferenceValidationRepositoryImpl(
        testResultDataSource: Get.find<TestResultDataSourceImpl>(),
        apiServices: Get.find<RestApiServices>(),
      ),
    );

    Get.lazyPut(
      () => ValidateReferenceCodeUseCase(
        repository: Get.find<ReferenceValidationRepository>(),
      ),
    );

    Get.put(ReferenceCodeController(
      validateReferenceCodeUseCase: Get.find<ValidateReferenceCodeUseCase>(),
    ));
  }
}
