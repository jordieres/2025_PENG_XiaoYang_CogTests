import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/config/translation/app_translations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: AppTranslations.locale,
      fallbackLocale: AppTranslations.fallbackLocale,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Messages.accountType.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Messages.alreadyHaveAccount.tr),
            ElevatedButton(
              onPressed: () => Get.updateLocale(AppTranslations.CHINIES),
              child: const Text('切换到中文'),
            ),
            ElevatedButton(
              onPressed: () => Get.updateLocale(AppTranslations.SPANISH),
              child: const Text('Camibar a español'),
            ),
            ElevatedButton(
              onPressed: () => Get.updateLocale(AppTranslations.ENGLISH),
              child: const Text('Switch to English'),
            ),
          ],
        ),
      ),
    );
  }
}
