import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../../domain/usecases/home_reference_select_user_width_calculator.dart';
import '../components/home_page_header.dart';
import '../components/reference_code_input.dart';
import '../components/select_user_dropdown.dart';
import '../controllers/reference_code_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with NavigationMixin {
  late ReferenceCodeController _referenceCodeController;

  @override
  void initState() {
    super.initState();
    _referenceCodeController = Get.find<ReferenceCodeController>();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = HomeReferenceSelectUserWidthCalculator.getMaxWidth(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Center(
            child: SizedBox(
              width: maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HomeHeader(),
                  const SizedBox(height: 20),
                  const SelectUserDropdown(),
                  const SizedBox(height: 20),
                  const ReferenceCodeInput(),
                  const SizedBox(height: 20),
                  Obx(() => ElevatedButton(
                    onPressed: _referenceCodeController.isValidated.value
                        ? () => toSelectedPracticeOrTest(_referenceCodeController.getFullReferenceCode())
                        : null,
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.grey.shade300,
                      disabledForegroundColor: Colors.grey.shade600,
                    ),
                    child: const Text('Empezar TMT Test'),
                  )),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => toRegisterUser(),
                    child: const Text("Ir a Alta Usuario"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.tmt_user_history),
                    child: const Text("Historial TMT"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.current_user_data),
                    child: const Text("Ir a Current User"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}