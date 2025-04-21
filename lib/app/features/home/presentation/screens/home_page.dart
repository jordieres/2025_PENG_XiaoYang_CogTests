import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../../../../utils/helpers/widget_max_width_calculator.dart';
import '../components/home_page_header.dart';
import '../components/reference_code_input.dart';
import '../components/select_user_dropdown.dart';
import '../components/tmt_test_button_card.dart'; // Import the new component
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
    final maxWidth =
    WidgetMaxWidthCalculator.getMaxWidth(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
        isDarkMode ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
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
                    // Replace the old button with the new TMT Test button card
                    Obx(() => TmtTestButtonCard(
                      referenceCode: _referenceCodeController.isValidated.value
                          ? _referenceCodeController.getFullReferenceCode()
                          : '',
                      onStartTest: _referenceCodeController.isValidated.value
                          ? () => toSelectedPracticeOrTest(
                          _referenceCodeController.getFullReferenceCode())
                          : null,
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
      ),
    );
  }
}