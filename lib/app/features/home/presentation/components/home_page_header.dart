import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/config/themes/AppColors.dart';
import '../../../../config/themes/theme_controller.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../constans/app_constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          ImageVectorPath.homeMadridIcon,
          width: 68,
          height: 40,
        ),
        Row(
          children: [
            Obx(() => IconButton(
              icon: Icon(
                themeController.isDarkMode
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: () {
                _showThemeDialog(context, themeController);
              },
            )),
            const SizedBox(width: 12),
            _buildLanguageSelector(context),
          ],
        ),
      ],
    );
  }

  String _getDisplayTextForLocale(String? languageCode) {
    if (languageCode == null) return HomeHeaderText.spanish.tr;

    switch (languageCode.toLowerCase()) {
      case AppTranslations.ENGLISH_LANGUAGE_CODE:
        return HomeHeaderText.english.tr;
      case AppTranslations.SPANISH_LANGUAGE_CODE:
        return HomeHeaderText.spanish.tr;
      case AppTranslations.CHINESE_LANGUAGE_CODE:
        return HomeHeaderText.chinese.tr;
      default:
        return HomeHeaderText.spanish.tr;
    }
  }

  Widget _buildLanguageSelector(BuildContext context) {
    String displayText = _getDisplayTextForLocale(Get.locale?.languageCode);
    return InkWell(
      onTap: () {
        _showLanguageMenu(context);
      },
      child: Container(
        width: displayText.length > 2 ? 50 : 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.mainRed,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            displayText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: displayText.length > 2 ? 14 : 16,
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
    Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    final buttonPosition = button.localToGlobal(Offset.zero, ancestor: overlay);
    final double menuWidth = 120.0;

    final RelativeRect position = RelativeRect.fromLTRB(
      buttonPosition.dx + button.size.width - menuWidth,
      buttonPosition.dy + button.size.height,
      overlay.size.width - (buttonPosition.dx + button.size.width),
      0,
    );

    showMenu(
      context: context,
      position: position,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.mainRed,
      items: [
        PopupMenuItem(
          onTap: () => Get.updateLocale(AppTranslations.ENGLISH),
          child: Text(HomeHeaderText.english.tr,
              style: TextStyle(color: Colors.white)),
        ),
        PopupMenuItem(
          onTap: () => Get.updateLocale(AppTranslations.SPANISH),
          child: Text(HomeHeaderText.spanish.tr,
              style: TextStyle(color: Colors.white)),
        ),
        PopupMenuItem(
          onTap: () => Get.updateLocale(AppTranslations.CHINIES),
          child: Text(HomeHeaderText.chinese.tr,
              style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  void _showThemeDialog(BuildContext context, ThemeController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(HomeHeaderText.selectThemeTitle.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: Text(HomeHeaderText.lightModeOption.tr),
              onTap: () {
                controller.setLightMode();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text(HomeHeaderText.darkModeOption.tr),
              onTap: () {
                controller.setDarkMode();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.brightness_auto),
              title: Text(HomeHeaderText.systemThemeOption.tr),
              onTap: () {
                controller.setSystemTheme();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}