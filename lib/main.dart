import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'app/config/routes/app_pages.dart';
import 'app/config/routes/app_route_observer.dart';
import 'app/config/themes/app_theme.dart';
import 'app/config/themes/theme_controller.dart';
import 'app/config/translation/app_translations.dart';
import 'app/features/home/HomePage.dart';
import 'app/features/tm_tst/data/repositories/pending_result_repository_impl.dart';
import 'app/features/tm_tst/domain/repository/pending_result_repository.dart';
import 'app/features/tm_tst/domain/usecases/tmt_result/pending_result_use_case.dart';
import 'app/utils/helpers/app_helpers.dart';
import 'app/utils/services/work_manager_handler.dart';
import 'app/utils/services/app_logger.dart';
import 'app/utils/services/net/rest_api_services.dart';
import 'app/features/tm_tst/domain/repository/tmt_result_repository.dart';
import 'app/features/tm_tst/data/repositories/tmt_result_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.init();
  //await WorkManagerHandler.initializeWorkManager(); //TODO remove comment
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceHelper.init(context);
    final ThemeController themeController = Get.put(ThemeController());

    final tmtPendingUseCase = PendingResultUseCase(
        pendingResultRepository: PendingResultRepositoryImpl(
      restApiServices,
    ));

    tmtPendingUseCase.hasPendingResults().then((hasPendingResults) {
      if (hasPendingResults) {
        tmtPendingUseCase.sendPendingResults();
      }
    });

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [appRouteObserver],
          initialRoute: AppPages.initial,
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
        ));
  }
}
