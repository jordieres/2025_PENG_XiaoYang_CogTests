import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../controllers/tmt_practice_flow_state_contoller.dart';

class TmtTESTPracticeBinding extends Bindings {
  @override
  void dependencies() {
    final controller = TmtPracticeFlowController();
    Get.put<TmtPracticeFlowController>(controller);
  }
}
