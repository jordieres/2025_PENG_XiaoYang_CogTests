import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/config/themes/AppColors.dart';
import 'package:msdtmt/app/config/themes/AppTextStyle.dart';
import 'package:msdtmt/app/utils/helpers/app_helpers.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../domain/usecases/home_reference_select_user_width_calculator.dart';
import '../controllers/reference_code_controller.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String upperCaseText = newValue.text.toUpperCase();
    String trimmedText = upperCaseText.trim();
    int selectionBase = newValue.selection.baseOffset;
    int selectionExtent = newValue.selection.extentOffset;

    if (upperCaseText.length > trimmedText.length &&
        selectionBase == upperCaseText.length) {
      selectionBase = trimmedText.length;
      selectionExtent = trimmedText.length;
    } else {
      selectionBase = min(selectionBase, trimmedText.length);
      selectionExtent = min(selectionExtent, trimmedText.length);
    }
    return TextEditingValue(
      text: trimmedText,
      selection: TextSelection(
        baseOffset: selectionBase,
        extentOffset: selectionExtent,
      ),
    );
  }
}

class ReferenceCodeInput extends StatefulWidget {
  const ReferenceCodeInput({super.key});

  @override
  State<ReferenceCodeInput> createState() => _ReferenceCodeInputState();
}

class _ReferenceCodeInputState extends State<ReferenceCodeInput> {
  final TextEditingController mainCodeController = TextEditingController();
  final TextEditingController suffixCodeController = TextEditingController();
  late final ReferenceCodeController controller;
  final FocusNode mainFocusNode = FocusNode();
  final FocusNode suffixFocusNode = FocusNode();

  String? errorMessage;

  BoxDecoration getReferenceCodeInputDecoration(
      bool isReadOnly, String? errorMessage) {
    return BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: errorMessage != null && !isReadOnly
              ? AppColors.mainRed
              : Colors.white,
          width: DeviceHelper.isTablet ? 2 : 1.5,
        ));
  }

  ThemeData getReferenceCodeTextSelectionTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Colors.white24,
        selectionHandleColor: Colors.white,
      ),
    );
  }

  double _getIconSize() {
    if (DeviceHelper.isTablet) {
      return 30.0;
    } else {
      return 24.0;
    }
  }

  @override
  void initState() {
    super.initState();
    controller = Get.find<ReferenceCodeController>();
    mainFocusNode.addListener(() {
      setState(() {});
    });

    ever(controller.isValidated, (isValidated) {
      if (isValidated) {
        FocusScope.of(context).unfocus();
        setState(() {
          errorMessage = null;
        });
      }
    });

    ever(controller.errorMessage, (message) {
      if (message.isNotEmpty) {
        setState(() {
          errorMessage = message;
        });
      } else {
        setState(() {
          errorMessage = null;
        });
      }
    });
  }

  @override
  void dispose() {
    mainCodeController.dispose();
    suffixCodeController.dispose();
    mainFocusNode.removeListener(() {});
    mainFocusNode.dispose();
    suffixFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasLabel =
        mainFocusNode.hasFocus || mainCodeController.text.isNotEmpty;
    final maxWidth = HomeReferenceSelectUserWidthCalculator.getMaxWidth(context);

    return Obx(() {
      final isReadOnly = controller.isValidated.value;

      return Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 84,
                decoration: BoxDecoration(
                  color:
                      AppColors.getPrimaryBlueDependIsDarkMode(Get.isDarkMode),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    _buildMainInputField(hasLabel, isReadOnly),
                    _buildSeparator(),
                    _buildSuffixInputField(isReadOnly),
                    _buildActionButton(isReadOnly),
                    const SizedBox(width: 18),
                  ],
                ),
              ),
              if (errorMessage != null && !isReadOnly)
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Text(
                    errorMessage!,
                    style: AppTextStyle.referenceCodeInputErrorTextStyle,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildMainInputField(bool hasLabel, bool isReadOnly) {
    return Expanded(
      flex: 3,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 60,
            decoration:
                getReferenceCodeInputDecoration(isReadOnly, errorMessage),
            child: Center(
              child: Theme(
                data: getReferenceCodeTextSelectionTheme(context),
                child: TextField(
                  controller: mainCodeController,
                  focusNode: mainFocusNode,
                  cursorColor: Colors.white,
                  cursorWidth: 2.0,
                  readOnly: isReadOnly,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  style: AppTextStyle.referenceCodeInputTextStyle,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    border: InputBorder.none,
                    hintText: hasLabel ? '' : ReferenceCodeInputText.label.tr,
                    hintStyle: AppTextStyle.referenceCodeHintTextStyle,
                  ),
                  onChanged: (value) {
                    if (errorMessage != null) {
                      setState(() {
                        errorMessage = null;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          if (hasLabel)
            Positioned(
              left: 14,
              top: -9,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                color: AppColors.getPrimaryBlueDependIsDarkMode(Get.isDarkMode),
                child: Text(ReferenceCodeInputText.label.tr,
                    style: TextStyleBase.bodyM.copyWith(
                      color: errorMessage != null && !isReadOnly
                          ? Colors.red
                          : Colors.white,
                    )),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        '—',
        style: TextStyleBase.h1.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildSuffixInputField(bool isReadOnly) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 60,
        decoration: getReferenceCodeInputDecoration(isReadOnly, errorMessage),
        child: Center(
          child: Theme(
            data: getReferenceCodeTextSelectionTheme(context),
            child: TextField(
              controller: suffixCodeController,
              focusNode: suffixFocusNode,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              cursorColor: Colors.white,
              cursorWidth: 2.0,
              readOnly: isReadOnly,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              style: AppTextStyle.referenceCodeInputTextStyle,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (errorMessage != null) {
                  setState(() {
                    errorMessage = null;
                  });
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(bool isReadOnly) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: IconButton(
        icon: isReadOnly
            ? Icon(
                Icons.edit,
                color: Colors.white,
                size: _getIconSize(),
              )
            : Icon(
                Icons.check,
                color: Colors.white,
                size: _getIconSize(),
              ),
        onPressed: () {
          if (isReadOnly) {
            controller.resetValidation();
          } else {
            final mainCode = mainCodeController.text;
            final suffixCode = suffixCodeController.text;

            if (mainCode.isEmpty || suffixCode.isEmpty) {
              setState(() {
                errorMessage = ReferenceCodeInputText.bothFieldsRequired.tr;
              });
              controller.showErrorMessage(errorMessage!);
              return;
            }
            controller.validateReferenceCode(mainCode, suffixCode);
          }
        },
      ),
    );
  }
}
