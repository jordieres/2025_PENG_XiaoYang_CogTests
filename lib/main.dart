import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/config/routes/app_pages.dart';
import 'app/config/translation/app_translations.dart';
import 'app/features/home/HomePage.dart';
import 'app/utils/helpers/app_helpers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceHelper().init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      translations: AppTranslations(),
      locale: AppTranslations.locale,
      fallbackLocale: AppTranslations.fallbackLocale,
      home: const HomePage(),
    );
  }
}
