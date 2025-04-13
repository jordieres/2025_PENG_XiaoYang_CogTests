import 'package:get/get.dart';

import '../../../../utils/services/user_data_base_helper.dart';
import '../../data/datasources/user_profle_data_soruce.dart';
import '../../domain/repository/user_profile_repository.dart';
import '../contoller/user_profile_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Database helper
    Get.lazyPut(
      () => UserDatabaseHelper(),
    );

    // Data sources
    Get.lazyPut<UserProfileDataSource>(
      () => UserProfileDataSourceImpl(
        databaseHelper: Get.find<UserDatabaseHelper>(),
      ),
    );

    // Repositories
    Get.lazyPut<UserProfileRepository>(
      () => UserProfileRepositoryImpl(
        profileDataSource: Get.find<UserProfileDataSource>(),
      ),
    );

    // Controllers
    Get.put(UserProfileController(
      repository: Get.find<UserProfileRepository>(),
    ));
  }
}
