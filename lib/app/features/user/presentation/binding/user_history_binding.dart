import 'package:get/get.dart';

import '../../../../utils/services/user_data_base_helper.dart';
import '../../data/datasources/test_result_data_soruce.dart';
import '../../domain/repository/test_result_local_data_repository.dart';
import '../contoller/test_result_controller.dart';

class UserHistoryBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<UserDatabaseHelper>()) {
      Get.lazyPut(() => UserDatabaseHelper());
    }

    if (!Get.isRegistered<TestResultLocalDataSource>()) {
      Get.lazyPut<TestResultLocalDataSource>(
        () => TestResultDataSourceImpl(
          databaseHelper: Get.find<UserDatabaseHelper>(),
        ),
      );
    }

    if (!Get.isRegistered<TestResultLocalDataRepository>()) {
      Get.lazyPut<TestResultLocalDataRepository>(
        () => TestResultLocalDataRepositoryImpl(
          testResultDataSource: Get.find<TestResultLocalDataSource>(),
        ),
      );
    }

    if (!Get.isRegistered<TestResultLocalDataController>()) {
      Get.put(TestResultLocalDataController(
        repository: Get.find<TestResultLocalDataRepository>(),
      ));
    }
  }
}
