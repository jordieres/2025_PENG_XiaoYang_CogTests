import 'package:get/get.dart';

import '../../../../utils/services/user_data_base_helper.dart';
import '../../data/datasources/test_result_data_soruce.dart';
import '../../domain/repository/test_result_repository.dart';
import '../contoller/test_result_controller.dart';

class TestResultBinding extends Bindings {
  @override
  void dependencies() {
    // Database helper
    Get.lazyPut(
      () => UserDatabaseHelper(),
    );

    Get.lazyPut<TestResultDataSource>(
      () => TestResultDataSourceImpl(
        databaseHelper: Get.find<UserDatabaseHelper>(),
      ),
    );

    Get.lazyPut<TestResultRepository>(
      () => TestResultRepositoryImpl(
        testResultDataSource: Get.find<TestResultDataSource>(),
      ),
    );

    Get.put(TestResultController(
      repository: Get.find<TestResultRepository>(),
    ));
  }
}
