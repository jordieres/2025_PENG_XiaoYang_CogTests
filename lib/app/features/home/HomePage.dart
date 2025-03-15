import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/app_pages.dart';
import '../../config/translation/app_translations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TMTGame.tmtGameCircleBegin.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(TMTGame.tmtGameCircleEnd.tr),
            ElevatedButton(
              onPressed: () => {
                Get.toNamed(Routes.tmt_test),
              },
              child: const Text('Start TMT Test'),
            ),
            ElevatedButton(
              onPressed: () => Get.updateLocale(AppTranslations.SPANISH),
              child: const Text('Cambiar a español'),
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