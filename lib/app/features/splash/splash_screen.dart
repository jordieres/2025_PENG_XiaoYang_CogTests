import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../config/routes/app_pages.dart';
import '../../config/routes/app_route_observer.dart';
import '../../config/themes/app_theme.dart';
import '../../config/themes/theme_controller.dart';
import '../../config/translation/app_translations.dart';
import '../../constans/app_constants.dart';
import '../../utils/helpers/app_helpers.dart';
import '../../utils/helpers/widget_max_width_calculator.dart';
import '../../utils/services/work_manager_handler.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  final TextStyle _splashTextStyle = TextStyle(
    color: Colors.white.withAlpha(205),
    fontSize: 16,
  );

  String _appVersion = '';
  String _buildNumber = '';

  @override
  void initState() {
    super.initState();
    _getVersionInfo();
    _initialize();
  }

  Future<void> _getVersionInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    await WorkManagerHandler.initializeWorkManager();
    _launchFullApp();
  }

  void _launchFullApp() {
    DeviceHelper.init(context);
    final ThemeController themeController = Get.put(ThemeController());

    runApp(Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [appRouteObserver],
          initialRoute: Routes.home,
          getPages: AppPages.routes,
          translations: AppTranslations(),
          locale: AppTranslations.locale,
          fallbackLocale: AppTranslations.fallbackLocale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            AppTranslations.ENGLISH,
            AppTranslations.SPANISH,
            AppTranslations.CHINIES
          ],
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeController.themeMode,
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4090E5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 3),
            Text(
              'MS-dTMT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 54,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(flex: 2),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Designed by:',
                  style: _splashTextStyle,
                ),
                SizedBox(height: 8),
                Image.asset(
                  ImageSplashPath.universityLogo,
                  height: 100,
                ),
                SizedBox(height: 8),
                Text(
                  'With the support from:',
                  style: _splashTextStyle,
                ),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(
                    ImageSplashPath.supportLogo,
                    height: 32,
                    width: WidgetMaxWidthCalculator.getMaxWidth(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Version $_appVersion($_buildNumber)',
              style: _splashTextStyle.copyWith(
                fontSize: 14,
                color: Colors.white.withAlpha(180),
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
