import 'package:get/get.dart';

import '../../../../utils/services/user_data_base_helper.dart';
import '../../data/datasources/test_result_data_soruce.dart';
import '../../domain/repository/test_result_local_data_repository.dart';
import '../contoller/test_result_controller.dart';

class TestResultLocalDataBinding extends Bindings {
  @override
  void dependencies() {
    // Database helper
    Get.lazyPut(
      () => UserDatabaseHelper(),
    );

    Get.lazyPut<TestResultLocalDataSource>(
      () => TestResultDataSourceImpl(
        databaseHelper: Get.find<UserDatabaseHelper>(),
      ),
    );

    Get.lazyPut<TestResultLocalDataRepository>(
      () => TestResultLocalDataRepositoryImpl(
        testResultDataSource: Get.find<TestResultLocalDataSource>(),
      ),
    );

    Get.put(TestResultLocalDataController(
      repository: Get.find<TestResultLocalDataRepository>(),
    ));
  }
}
