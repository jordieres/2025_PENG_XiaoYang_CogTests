import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../config/themes/AppTextStyle.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/themes/input_decoration.dart';
import '../../../../config/translation/app_translations.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecase/register_user_screen_responsive_calculator.dart';
import '../contoller/user_profile_controller.dart';
import '../../../../shared_components/custom_app_bar.dart';

abstract class RegisterUserScreenBase extends StatefulWidget {
  const RegisterUserScreenBase({super.key});
}

abstract class RegisterUserScreenBaseState<T extends RegisterUserScreenBase>
    extends State<T> {
  static const double kFieldVerticalSpacing = 24.0;
  static const double kSexFieldVerticalSpacing = 16.0;
  static const double kLabelFieldSpacing = 8.0;
  static const double kButtonSpacing = 16.0;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey formBoxKey = GlobalKey();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final FocusNode nicknameFocusNode = FocusNode();
  final FocusNode birthDateFocusNode = FocusNode();
  final FocusNode educationLevelFocusNode = FocusNode();

  Sex? selectedSex;
  DateTime? selectedBirthDate;
  EducationLevel? selectedEducationLevel;

  bool isLoading = false;
  bool isNicknameExists = false;
  String? nicknameErrorText;

  bool nicknameVisited = false;
  bool sexVisited = false;
  bool birthDateVisited = false;
  bool educationLevelVisited = false;
  bool formSubmitted = false;

  double formHeight = 0;
  bool isFormMeasured = false;

  late UserProfileController controller;

  bool get isReadOnly => false;

  bool get showValidationErrors => !isReadOnly;

  @override
  void initState() {
    super.initState();
    controller = Get.find<UserProfileController>();

    if (!isReadOnly) {
      nicknameFocusNode.addListener(_onNicknameFocusChange);
      birthDateFocusNode.addListener(_onBirthDateFocusChange);
      educationLevelFocusNode.addListener(_onEducationLevelFocusChange);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateFormHeight();
    });
  }

  void updateFormHeight() {
    if (formBoxKey.currentContext != null && mounted) {
      final RenderBox box =
          formBoxKey.currentContext!.findRenderObject() as RenderBox;

      if (box.hasSize) {
        setState(() {
          formHeight = box.size.height;
          isFormMeasured = true;
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          updateFormHeight();
        });
      }
    }
  }

  double _calculateSpacing(double availableHeight) {
    if (!isFormMeasured) {
      return RegisterUserScreenResponsiveCalculator.kDefaultSpacing;
    }
    return RegisterUserScreenResponsiveCalculator
        .calculateSpacingBetweenFormAndButtons(
      context,
      availableHeight,
      formHeight,
    );
  }

  void _onNicknameFocusChange() {
    if (nicknameFocusNode.hasFocus) {
      formKey.currentState?.validate();
    }
  }

  void _onBirthDateFocusChange() {
    if (birthDateFocusNode.hasFocus) {
      formKey.currentState?.validate();
    }
  }

  void _onEducationLevelFocusChange() {
    if (educationLevelFocusNode.hasFocus) {
      formKey.currentState?.validate();
    }
  }

  @override
  void dispose() {
    nicknameController.dispose();
    birthDateController.dispose();
    if (!isReadOnly) {
      nicknameFocusNode.removeListener(_onNicknameFocusChange);
      birthDateFocusNode.removeListener(_onBirthDateFocusChange);
      educationLevelFocusNode.removeListener(_onEducationLevelFocusChange);
    }
    nicknameFocusNode.dispose();
    birthDateFocusNode.dispose();
    educationLevelFocusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    if (isReadOnly) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: Get.locale,
      helpText: TMTRegisterUserText.birthDatePickerTitle.tr,
      cancelText: TMTRegisterUserText.birthDatePickerCancel.tr,
      confirmText: TMTRegisterUserText.birthDatePickerConfirm.tr,
    );
    if (picked != null && picked != selectedBirthDate) {
      setState(() {
        selectedBirthDate = picked;
        birthDateVisited = true;
        nicknameVisited = true;
        sexVisited = true;
        final currentLocale = Get.locale?.toString() ?? 'en_US';
        birthDateFocusNode.removeListener(_onBirthDateFocusChange);
        birthDateController.text = DateFormat.yMd(currentLocale).format(picked);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          birthDateController.selection = TextSelection.collapsed(
            offset: birthDateController.text.length,
          );
        });

        birthDateFocusNode.addListener(_onBirthDateFocusChange);
      });
    }

    formKey.currentState?.validate();
  }

  bool get isFormComplete {
    return nicknameController.text.isNotEmpty &&
        selectedBirthDate != null &&
        selectedSex != null &&
        selectedEducationLevel != null &&
        !isNicknameExists;
  }

  String getScreenTitle();

  Widget buildActionButtons(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = CustomAppBar(title: getScreenTitle());
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: RegisterUserScreenResponsiveCalculator
                    .calculateContainerWidth(
                  context,
                ),
                padding: const EdgeInsets.fromLTRB(
                    RegisterUserScreenResponsiveCalculator
                        .kContentHorizontalPadding,
                    RegisterUserScreenResponsiveCalculator.kContentTopPadding,
                    RegisterUserScreenResponsiveCalculator
                        .kContentHorizontalPadding,
                    RegisterUserScreenResponsiveCalculator
                        .kContentBottomPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      key: formBoxKey,
                      child: _buildFormFields(isLandscape),
                    ),
                    SizedBox(height: _calculateSpacing(availableHeight)),
                    buildActionButtons(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFormFields(bool isLandscape) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNicknameField(),
          const SizedBox(height: kFieldVerticalSpacing),
          _buildSexField(),
          const SizedBox(height: kSexFieldVerticalSpacing),
          _buildBirthDateField(),
          const SizedBox(height: kFieldVerticalSpacing),
          _buildEducationLevelField(),
        ],
      ),
    );
  }

  Widget _buildNicknameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TMTRegisterUserText.nicknameLabel.tr,
            style: AppTextStyle.registerUserLabelText),
        const SizedBox(height: kLabelFieldSpacing),
        TextFormField(
          controller: nicknameController,
          focusNode: nicknameFocusNode,
          readOnly: isReadOnly,
          enabled: !isReadOnly,
          decoration: CustomInputDecoration.commonInputDecoration().copyWith(
            hintText: isReadOnly ? null : TMTRegisterUserText.nicknameHint.tr,
            filled: isReadOnly,
          ),
          validator: (value) {
            if (!showValidationErrors) return null;

            if ((nicknameVisited || formSubmitted)) {
              if (nicknameFocusNode.hasFocus) {
                return null;
              }
              if (value == null || value.isEmpty) {
                return TMTRegisterUserText.nicknameError.tr;
              }
              if (isNicknameExists) {
                return nicknameErrorText;
              }
            }
            return null;
          },
          onTap: () {
            if (!isReadOnly) {
              setState(() => nicknameVisited = true);
            }
          },
          onChanged: (value) {
            if (isReadOnly) return;

            setState(() {
              nicknameVisited = true;
              isNicknameExists = false;
              nicknameErrorText = null;
            });
            formKey.currentState?.validate();
          },
          style: CustomInputDecoration.textInputStyle,
        ),
      ],
    );
  }

  Widget _buildSexField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TMTRegisterUserText.sexLabel.tr,
            style: AppTextStyle.registerUserLabelText),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<Sex>(
              value: Sex.male,
              groupValue: selectedSex,
              activeColor: CustomInputDecoration.focusColor,
              onChanged: isReadOnly
                  ? null
                  : (Sex? value) {
                      setState(() {
                        selectedSex = value;
                        sexVisited = true;
                        nicknameVisited = true;
                      });
                      formKey.currentState?.validate();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        updateFormHeight();
                      });
                    },
            ),
            Text(TMTRegisterUserText.sexMale.tr,
                style: CustomInputDecoration.textInputStyle),
            SizedBox(width: 20),
            Radio<Sex>(
              value: Sex.female,
              groupValue: selectedSex,
              activeColor: CustomInputDecoration.focusColor,
              onChanged: isReadOnly
                  ? null
                  : (Sex? value) {
                      setState(() {
                        selectedSex = value;
                        sexVisited = true;
                        nicknameVisited = true;
                      });
                      formKey.currentState?.validate();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        updateFormHeight();
                      });
                    },
            ),
            Text(TMTRegisterUserText.sexFemale.tr,
                style: CustomInputDecoration.textInputStyle),
          ],
        ),
        if (showValidationErrors &&
            (sexVisited || formSubmitted) &&
            selectedSex == null)
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 12.0, bottom: 8.0),
            child: Text(
              TMTRegisterUserText.sexError.tr,
              style: TextStyleBase.bodyS.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBirthDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TMTRegisterUserText.birthDateLabel.tr,
            style: AppTextStyle.registerUserLabelText),
        const SizedBox(height: kLabelFieldSpacing),
        TextFormField(
          controller: birthDateController,
          focusNode: birthDateFocusNode,
          readOnly: true,
          decoration: CustomInputDecoration.commonInputDecoration().copyWith(
            hintText: isReadOnly ? null : TMTRegisterUserText.birthDateHint.tr,
            suffixIcon: isReadOnly
                ? null
                : Icon(Icons.calendar_today, color: Color(0xFF8F9098)),
            filled: isReadOnly,
            enabled: !isReadOnly,
          ),
          onTap: () => isReadOnly ? null : _selectDate(context),
          validator: (value) {
            if (!showValidationErrors) return null;

            if ((birthDateVisited || formSubmitted)) {
              if (birthDateFocusNode.hasFocus) {
                return null;
              }
              if (selectedBirthDate == null) {
                return TMTRegisterUserText.birthDateError.tr;
              }
            }
            return null;
          },
          style: CustomInputDecoration.textInputStyle,
        ),
      ],
    );
  }

  Widget _buildEducationLevelField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TMTRegisterUserText.educationLabel.tr,
            style: AppTextStyle.registerUserLabelText),
        const SizedBox(height: kLabelFieldSpacing),
        isReadOnly
            ? _buildReadOnlyEducationLevel()
            : _buildEditableEducationLevel(),
      ],
    );
  }

  Widget _buildReadOnlyEducationLevel() {
    return TextFormField(
      initialValue: selectedEducationLevel != null
          ? getEducationLevelText(selectedEducationLevel!)
          : '',
      readOnly: true,
      enabled: false,
      decoration:
          CustomInputDecoration.commonInputDecoration().copyWith(filled: true),
      style: CustomInputDecoration.textInputStyle,
    );
  }

  Widget _buildEditableEducationLevel() {
    return DropdownButtonFormField<EducationLevel>(
      value: selectedEducationLevel,
      focusNode: educationLevelFocusNode,
      decoration: CustomInputDecoration.commonInputDecoration().copyWith(),
      hint: Text(
        TMTRegisterUserText.educationHint.tr,
        style: CustomInputDecoration.commonInputDecoration().hintStyle,
      ),
      items: EducationLevel.values
          .map((level) => DropdownMenuItem(
                value: level,
                child: Text(
                  getEducationLevelText(level),
                  style: CustomInputDecoration.textInputStyle,
                ),
              ))
          .toList(),
      onChanged: (EducationLevel? value) {
        setState(() {
          selectedEducationLevel = value;
          educationLevelVisited = true;
          nicknameVisited = true;
          sexVisited = true;
          birthDateVisited = true;
        });
        formKey.currentState?.validate();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          updateFormHeight();
        });
      },
      validator: (value) {
        if (!showValidationErrors) return null;

        if ((educationLevelVisited || formSubmitted)) {
          if (educationLevelFocusNode.hasFocus) {
            return null;
          }
          if (value == null) {
            return TMTRegisterUserText.educationError.tr;
          }
        }
        return null;
      },
      isExpanded: true,
    );
  }

  String getEducationLevelText(EducationLevel level) {
    switch (level) {
      case EducationLevel.primary:
        return TMTRegisterUserText.educationPrimary.tr;
      case EducationLevel.secondary:
        return TMTRegisterUserText.educationSecondary.tr;
      case EducationLevel.graduate:
        return TMTRegisterUserText.educationGraduate.tr;
      case EducationLevel.master:
        return TMTRegisterUserText.educationMaster.tr;
      case EducationLevel.doctorate:
        return TMTRegisterUserText.educationDoctorate.tr;
    }
  }
}
