import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/app_pages.dart';
import '../../config/themes/theme_controller.dart';
import '../../config/translation/app_translations.dart';
import '../../utils/mixins/app_mixins.dart';
import '../tm_tst/presentation/screens/tmt_test_help.dart';
import '../user/presentation/contoller/user_profile_controller.dart';

class HomePage extends StatelessWidget with NavigationMixin {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(TMTGameText.tmtGameCircleBegin.tr),
        actions: [
          Obx(() =>
              IconButton(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
              {
                Get.toNamed(Routes.tmt_test),
              },
              child: const Text('Emepzar TMT Test'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () =>
              {
                tmtTestToHelp(TmtHelpMode.TMT_PRACTICE_A),
              },
              child: const Text("Empezar con TMT test Práctica"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () =>
              {
                toRegisterUser(),
              },
              child: const Text("Ir a Alta Usuario"),
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
    );
  }

  void _showThemeDialog(BuildContext context, ThemeController controller) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
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
