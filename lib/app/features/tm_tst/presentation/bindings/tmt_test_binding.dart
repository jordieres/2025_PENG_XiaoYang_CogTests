import 'package:get/get.dart';
import '../controllers/tmt_test_controller.dart';

class TmtTESTBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TmtTestController());
  }
}
