import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/routes/app_pages.dart';
import '../../config/translation/app_translations.dart';
import '../../shared_components/custom_dialog.dart';
import '../../utils/mixins/app_mixins.dart';
import '../tm_tst/presentation/screens/tmt_test_help.dart';
import '../tm_tst/presentation/screens/tmt_test_practice_screen.dart';

class HomePage extends StatelessWidget with NavigationMixin {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //getDeviceInfo();

















    return Scaffold(
      appBar: AppBar(
        title: Text(TMTGame.tmtGameCircleBegin.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => {
                Get.toNamed(Routes.tmt_test),
              },
              child: const Text('Start TMT Test'),
            ),
            ElevatedButton(
              onPressed: () => {
                tmtTestToHelp(TmtHelpMode.TMT_PRACTICE_A),
              },
              child: const Text("Start TMT Practice"),
            ),
            ElevatedButton(
              onPressed: () => Get.updateLocale(AppTranslations.SPANISH),
              child: const Text('Cambiar a español'),
            ),
            ElevatedButton(
              onPressed: () => Get.updateLocale(AppTranslations.ENGLISH),
              child: const Text('Switch to English'),
            ),
            ElevatedButton(
              onPressed: () => Get.updateLocale(AppTranslations.CHINIES),
              child: const Text('切换到中文'),
            ),
          ],
        ),
      ),
    );
  }

/*
  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('品牌: ${androidInfo.brand}');
      print('设备型号: ${androidInfo.model}');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('设备名称: ${iosInfo.name}');
      print('型号: ${iosInfo.model}');
    }
  }*/
}
