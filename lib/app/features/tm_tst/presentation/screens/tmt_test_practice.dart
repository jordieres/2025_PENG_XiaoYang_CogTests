import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared_components/custom_app_bar.dart';
import '../../../../shared_components/custom_primary_button.dart';
import '../../../../shared_components/custom_secondary_button.dart';
import '../../../../utils/helpers/app_helpers.dart';

class TmtTestPracticePage extends StatelessWidget {
  const TmtTestPracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Practicar",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Practicar",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: DeviceHelper.isTablet ? 46 : 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPrimaryButton(
                    text: "Terminar",
                    onPressed: () {
                      Get.close(2);
                    },
                  ),
                  SizedBox(height: DeviceHelper.isTablet ? 28 : 22),
                  CustomSecondaryButton(
                    text: "Repetir",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
