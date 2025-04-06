import 'package:get/get.dart';

import '../../../../utils/services/user_data_base_helper.dart';
import '../../data/datasources/user_local_data_source.dart';
import '../../domain/repository/user_repository.dart';
import '../contoller/user_profile_controller.dart';

class RegisterUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => UserDatabaseHelper(),
    );

    Get.lazyPut<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(
        databaseHelper: Get.find<UserDatabaseHelper>(),
      ),
    );

    // Repository
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        localDataSource: Get.find<UserLocalDataSource>(),
      ),
    );

    // Controller
    Get.put(UserProfileController(
      repository: Get.find<UserRepository>(),
    ));
  }
}
