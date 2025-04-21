import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../../../../utils/helpers/widget_max_width_calculator.dart';
import '../components/home_card_button.dart';
import '../components/home_page_header.dart';
import '../components/reference_code_input.dart';
import '../components/select_user_dropdown.dart';
import '../components/tmt_test_button_card.dart';
import '../controllers/reference_code_controller.dart';
import '../controllers/select_user_profile_controller.dart';
import '../../../../config/translation/app_translations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with NavigationMixin {
  late ReferenceCodeController _referenceCodeController;
  late SelectUserController _selectUserController;

  @override
  void initState() {
    super.initState();
    _referenceCodeController = Get.find<ReferenceCodeController>();
    _selectUserController = Get.find<SelectUserController>();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = WidgetMaxWidthCalculator.getMaxWidth(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness:
                isDarkMode ? Brightness.dark : Brightness.light,
            statusBarIconBrightness:
                isDarkMode ? Brightness.light : Brightness.dark,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
          child: Center(
            child: SizedBox(
              width: maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HomeHeader(),
                  const SizedBox(height: 38),
                  const SelectUserDropdown(),
                  const SizedBox(height: 32),
                  Obx(() => ReferenceCodeInput(
                        isActive:
                            _selectUserController.currentProfile.value != null,
                      )),
                  const SizedBox(height: 24),
                  Obx(() => TmtTestButtonCard(
                        referenceCode: _referenceCodeController
                                .isValidated.value
                            ? _referenceCodeController.getFullReferenceCode()
                            : '',
                        onStartTest: _referenceCodeController.isValidated.value
                            ? () => toSelectedPracticeOrTest(
                                _referenceCodeController.getFullReferenceCode())
                            : null,
                      )),
                  const SizedBox(height: 24),
                  Obx(() => Row(
                        children: [
                          Expanded(
                            child: HomeCardButton(
                              text: HomeCardButtonText.visualizeMyData.tr,
                              onPressed: () => toCurrentUserData(),
                              isActive:
                                  _selectUserController.currentProfile.value !=
                                      null,
                            ),
                          ),
                          const SizedBox(width: 23),
                          Expanded(
                            child: HomeCardButton(
                              text: HomeCardButtonText.viewMyHistory.tr,
                              onPressed: () => toUserTmtResultHistory(),
                              isActive:
                                  _selectUserController.currentProfile.value !=
                                      null,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 24),
                  HomeCardButton(
                    text: HomeCardButtonText.createNewProfile.tr,
                    middleHeight: true,
                    onPressed: () => toRegisterUser(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
