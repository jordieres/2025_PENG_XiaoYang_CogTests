import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/config/routes/app_pages.dart';
import 'app/config/routes/app_route_observer.dart';
import 'app/config/themes/app_theme.dart';
import 'app/config/themes/theme_controller.dart';
import 'app/config/translation/app_translations.dart';
import 'app/features/home/HomePage.dart';
import 'app/utils/helpers/app_helpers.dart';
import 'app/utils/services/app_logger.dart';
import 'app/utils/services/net/rest_api_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO put all init in one class
    DeviceHelper.init(context);
    AppLogger.init();
    final ThemeController themeController = Get.put(ThemeController());
    
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [appRouteObserver],
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          translations: AppTranslations(),
          locale: AppTranslations.locale,
          fallbackLocale: AppTranslations.fallbackLocale,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeController.themeMode,
          home: const HomePage(),
        ));
  }
}
