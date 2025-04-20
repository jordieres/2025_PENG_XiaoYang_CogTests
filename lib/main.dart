import 'package:flutter/material.dart';
import 'app/features/splash/splash_screen.dart';
import 'app/utils/services/app_logger.dart';

void main() async {
  AppLogger.init();
  runApp(const InitialApp());
}

class InitialApp extends StatelessWidget {
  const InitialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomSplashScreen(),
    );
  }
}