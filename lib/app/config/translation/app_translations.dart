import 'dart:ui';
import 'package:get/get.dart';

part 'app_messages.dart';

part 'en.dart';

part 'es.dart';

part 'zh.dart';

class AppTranslations extends Translations {
  static Locale? get locale => Get.deviceLocale;

  static Locale? get fallbackLocale => const Locale(ENGLISH_LANGUAGE_CODE, "");

  static const Locale ENGLISH = Locale(ENGLISH_LANGUAGE_CODE, "");
  static const Locale SPANISH = Locale(SPANISH_LANGUAGE_CODE, "");
  static const Locale CHINIES = Locale(CHINESE_LANGUAGE_CODE, "");

  static const ENGLISH_LANGUAGE_CODE = 'en';
  static const SPANISH_LANGUAGE_CODE = 'es';
  static const CHINESE_LANGUAGE_CODE = 'zh';

  @override
  Map<String, Map<String, String>> get keys => {
        ENGLISH_LANGUAGE_CODE: en.messages,
        SPANISH_LANGUAGE_CODE: es.messages,
        CHINESE_LANGUAGE_CODE: zh.messages,
      };
}
