import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/features/splash/splash_screen.dart';
import 'app/utils/services/app_logger.dart';

void main() async {
  AppLogger.init();
  await dotenv.load(fileName: ".env");
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