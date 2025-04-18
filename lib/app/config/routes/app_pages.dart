import 'package:get/get.dart';
import 'package:msdtmt/app/features/home/presentation/binding/home_screen_binding.dart';
import 'package:msdtmt/app/features/home/presentation/screens/home_page.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/bindings/tmt_result_binding.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/bindings/tmt_test_binding.dart';
import 'package:msdtmt/app/features/tm_tst/presentation/screens/tmt_test_screen.dart';

import '../../features/home/presentation/binding/reference_validation_biding.dart';
import '../../features/home/presentation/binding/select_user_profile_binding.dart';
import '../../features/tm_tst/presentation/bindings/tmt_game_config_biding.dart';
import '../../features/tm_tst/presentation/bindings/tmt_test_practice_binding.dart';
import '../../features/tm_tst/presentation/screens/tmt_select_mode_practice_or_test.dart';
import '../../features/tm_tst/presentation/screens/tmt_test_help.dart';
import '../../features/tm_tst/presentation/screens/tmt_test_practice_screen.dart';
import '../../features/tm_tst/presentation/screens/tmt_test_result_screen.dart';
import '../../features/user/presentation/binding/test_result_local_data_binding.dart';
import '../../features/user/presentation/binding/user_history_binding.dart';
import '../../features/user/presentation/binding/user_profile_binding.dart';
import '../../features/user/presentation/screen/current_user_data_screen.dart';
import '../../features/user/presentation/screen/register_user_screen.dart';
import '../../features/user/presentation/screen/user_result_history_screen.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomePage(),
      bindings: [
        ReferenceValidationBinding(),
        SelectUserBinding(),
        HomeScreenBinding(),
        TmtGameConfigBinding(),
      ],
    ),
    GetPage(
      name: _Paths.tmt_test,
      page: () => const TmtTestPage(),
      bindings: [
        TmtTESTBinding(),
        TmtGameConfigBinding(),
      ],
    ),
    GetPage(
      name: _Paths.tmt_results,
      page: () => const TmtResultsScreen(),
      bindings: [
        TmtResultBinding(),
        TestResultLocalDataBinding(),
      ],
    ),
    GetPage(
      name: _Paths.tmt_help,
      page: () => const TmtTestHelpPage(),
    ),
    GetPage(
      name: _Paths.tmt_practice,
      page: () => const TmtTestPracticePage(),
      binding: TmtTESTPracticeBinding(),
    ),
    GetPage(
      name: _Paths.tmt_select_practice_or_test,
      page: () => SelectModePracticeOrTest(),
    ),
    GetPage(
      name: _Paths.register_user,
      page: () => RegisterUserScreen(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: _Paths.current_user_data,
      page: () => CurrentUserDataScreen(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: _Paths.user_history,
      page: () => const UserResultHistoryScreen(),
      binding: UserHistoryBinding(),
    ),
  ];
}
