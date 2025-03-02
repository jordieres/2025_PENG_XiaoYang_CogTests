import 'dart:ui';
import 'package:get/get.dart';

part 'app_messages.dart';

part 'en.dart';

part 'es.dart';

part 'zh.dart';

class AppTranslations extends Translations {
  static Locale? get locale => Get.deviceLocale;

  static Locale? get fallbackLocale => const Locale('en');

  static const Locale ENGLISH = Locale('en');
  static const Locale SPANISH = Locale('es');
  static const Locale CHINIES = Locale('zh');

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en.messages,
        'es': es.messages,
        'zh': zh.messages,
      };
}
