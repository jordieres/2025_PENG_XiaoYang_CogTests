
import '../../../../shared_components/header_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TmtTestPage extends StatelessWidget {
  const TmtTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const HeaderText("TMT Test"),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
