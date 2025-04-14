import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/themes/theme_controller.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../utils/mixins/app_mixins.dart';
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
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('TMT Test App'),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  themeController.isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () {
                  _showThemeDialog(context, themeController);
                },
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ReferenceCodeInput(),
              const SizedBox(height: 20),
              const SelectUserDropdown(),
              const SizedBox(height: 20),
              Obx(() => ElevatedButton(
                    onPressed: _referenceCodeController.isValidated.value
                        ? () => {
                              toSelectedPracticeOrTest(_referenceCodeController
                                  .getFullReferenceCode())
                            }
                        : null,
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.grey.shade300,
                      disabledForegroundColor: Colors.grey.shade600,
                    ),
                    child: const Text('Empezar TMT Test'),
                  )),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => {
                  toRegisterUser(),
                },
                child: const Text("Ir a Alta Usuario"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => {
                  Get.toNamed(Routes.tmt_user_history),
                },
                child: const Text("Historial TMT"),
              ),
              ElevatedButton(
                onPressed: () => {
                  Get.toNamed(Routes.current_user_data),
                },
                child: const Text("Ir a Current User"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.updateLocale(AppTranslations.SPANISH),
                child: const Text('Cambiar a español'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Get.updateLocale(AppTranslations.ENGLISH),
                child: const Text('Switch to English'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Get.updateLocale(AppTranslations.CHINIES),
                child: const Text('切换到中文'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context, ThemeController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: const Text('Light Mode'),
              onTap: () {
                controller.setLightMode();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              onTap: () {
                controller.setDarkMode();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.brightness_auto),
              title: const Text('System Theme'),
              onTap: () {
                controller.setSystemTheme();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
