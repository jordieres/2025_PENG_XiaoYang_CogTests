import 'package:get/get.dart';
import 'package:msdtmt/app/features/home/HomePage.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/bindings/tmt_test_binding.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/screens/tmt_test_screen.dart';

import '../../features/tm_tst/presentation/screens/tmt_test_help.dart';
import '../../features/tm_tst/presentation/screens/tmt_test_result_screen.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: _Paths.tmt_test,
      page: () => const TmtTestPage(),
      binding: TmtTESTBinding(),
    ),
    GetPage(
      name: _Paths.tmt_results,
      page: () => const TmtResultsScreen(),
    ),
    GetPage(
      name: _Paths.tmt_help,
      page: () => const TmtTestHelpPage(),
    ),
  ];
}
