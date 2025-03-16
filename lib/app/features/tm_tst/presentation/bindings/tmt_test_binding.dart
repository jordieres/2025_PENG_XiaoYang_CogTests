import 'package:get/get.dart';
import '../controllers/tmt_test_flow_state_controller.dart';


class TmtTESTBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TmtTestFlowStateController());
  }
}