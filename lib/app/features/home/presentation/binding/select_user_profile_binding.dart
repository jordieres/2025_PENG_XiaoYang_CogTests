import 'package:get/get.dart';
import '../../../../utils/services/user_data_base_helper.dart';
import '../../../user/data/datasources/user_profle_data_soruce.dart';
import '../../../user/domain/repository/user_profile_repository.dart';
import '../controllers/select_user_profile_controller.dart';

class SelectUserBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<UserDatabaseHelper>()) {
      Get.lazyPut(() => UserDatabaseHelper());
    }

    Get.lazyPut<UserProfileDataSource>(
      () => UserProfileDataSourceImpl(
        databaseHelper: Get.find<UserDatabaseHelper>(),
      ),
    );

    Get.lazyPut<UserProfileRepository>(
      () => UserProfileRepositoryImpl(
        profileDataSource: Get.find<UserProfileDataSource>(),
      ),
    );

    Get.lazyPut<SelectUserController>(() => SelectUserController());
  }
}
