import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/config/themes/AppColors.dart';
import '../controllers/reference_code_controller.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
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

  final TextStyle _inputTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  final TextStyle _hintTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  BoxDecoration _getInputDecoration(bool isReadOnly) {
    return BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: errorMessage != null && !isReadOnly
                ? AppColors.mainRed
                : Colors.white,
            width: 1.5));
  }

  ThemeData _getTextSelectionTheme() {
    return Theme.of(context).copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Colors.white24,
        selectionHandleColor: Colors.white,
      ),
    );
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

    return Obx(() {
      final isReadOnly = controller.isValidated.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 84,
            decoration: BoxDecoration(
              color: AppColors.getPrimaryBlueDependIsDarkMode(Get.isDarkMode),
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
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
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
            decoration: _getInputDecoration(isReadOnly),
            child: Theme(
              data: _getTextSelectionTheme(),
              child: TextField(
                controller: mainCodeController,
                focusNode: mainFocusNode,
                cursorColor: Colors.white,
                cursorWidth: 2.0,
                readOnly: isReadOnly,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                style: _inputTextStyle,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: InputBorder.none,
                  hintText: hasLabel ? '' : 'Referencia',
                  hintStyle: _hintTextStyle,
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
          if (hasLabel)
            Positioned(
              left: 14,
              top: -9,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                color: AppColors.getPrimaryBlueDependIsDarkMode(Get.isDarkMode),
                child: Text(
                  'Referencia',
                  style: TextStyle(
                    color: errorMessage != null && !isReadOnly
                        ? Colors.red
                        : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        '—',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }

  Widget _buildSuffixInputField(bool isReadOnly) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 60,
        decoration: _getInputDecoration(isReadOnly),
        child: Theme(
          data: _getTextSelectionTheme(),
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
            style: _inputTextStyle,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
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
    );
  }

  Widget _buildActionButton(bool isReadOnly) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: IconButton(
        icon: isReadOnly
            ? const Icon(Icons.edit, color: Colors.white)
            : const Icon(Icons.check, color: Colors.white),
        onPressed: () {
          if (isReadOnly) {
            controller.resetValidation();
          } else {
            final mainCode = mainCodeController.text;
            final suffixCode = suffixCodeController.text;

            if (mainCode.isEmpty || suffixCode.isEmpty) {
              setState(() {
                errorMessage = 'Por favor, complete ambos campos';
              });
              controller.showErrorMessage(errorMessage!);
              return;
            }

            final fullCode = '$mainCode-$suffixCode';
            controller.validateReferenceCode(fullCode);
          }
        },
      ),
    );
  }
}
