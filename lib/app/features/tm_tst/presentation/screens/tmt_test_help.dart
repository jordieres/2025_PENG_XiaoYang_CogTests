import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/routes/app_pages.dart';

class TmtTestHelpPage extends StatelessWidget {
  const TmtTestHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Help"),
            ElevatedButton(
              onPressed: () {
                Get.close(1);
              },
              child: Text("Back"),
            ),

          ],
        ),
      ),
    );
  }
}
