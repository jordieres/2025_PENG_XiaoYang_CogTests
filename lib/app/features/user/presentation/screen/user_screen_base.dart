import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../config/themes/AppTextStyle.dart';
import '../../../../config/themes/input_decoration.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../home/domain/usecases/home_reference_select_user_width_calculator.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecase/register_user_screen_responsive_calculator.dart';
import '../contoller/user_profile_controller.dart';
import '../../../../shared_components/custom_app_bar.dart';
import '../../../../utils/helpers/app_helpers.dart';

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
  double formHeight = 0;
  bool isFormMeasured = false;

  late UserProfileController controller;

  bool get isReadOnly => false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<UserProfileController>();

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

  @override
  void dispose() {
    nicknameController.dispose();
    birthDateController.dispose();
    nicknameFocusNode.dispose();
    birthDateFocusNode.dispose();
    educationLevelFocusNode.dispose();
    super.dispose();
  }

  bool get isFormComplete {
    return nicknameController.text.isNotEmpty &&
        selectedBirthDate != null &&
        selectedSex != null &&
        selectedEducationLevel != null;
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
                width: HomeReferenceSelectUserWidthCalculator.getMaxWidth(context),
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
          validator: validateNicknameField,
          onTap: onNicknameFieldTap,
          onChanged: onNicknameFieldChanged,
          style: CustomInputDecoration.textInputStyle,
        ),
      ],
    );
  }

  String? validateNicknameField(String? value) {
    return null;
  }

  void onNicknameFieldTap() {
    // To be overridden by subclasses if needed
  }

  void onNicknameFieldChanged(String value) {
    // To be overridden by subclasses if needed
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
              onChanged: isReadOnly ? null : onSexChanged,
            ),
            Text(TMTRegisterUserText.sexMale.tr,
                style: CustomInputDecoration.textInputStyle),
            SizedBox(width: 20),
            Radio<Sex>(
              value: Sex.female,
              groupValue: selectedSex,
              activeColor: CustomInputDecoration.focusColor,
              onChanged: isReadOnly ? null : onSexChanged,
            ),
            Text(TMTRegisterUserText.sexFemale.tr,
                style: CustomInputDecoration.textInputStyle),
          ],
        ),
        buildSexValidationError(),
      ],
    );
  }

  Widget buildSexValidationError() {
    return SizedBox.shrink();
  }

  void onSexChanged(Sex? value) {
    if (!isReadOnly) {
      setState(() {
        selectedSex = value;
      });
    }
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
          onTap: isReadOnly ? null : () => selectDate(context),
          validator: validateBirthDateField,
          style: CustomInputDecoration.textInputStyle,
        ),
      ],
    );
  }

  String? validateBirthDateField(String? value) {
    return null;
  }

  Future<void> selectDate(BuildContext context) async {
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
        final currentLocale = Get.locale?.toString() ?? 'en_US';
        birthDateController.text = DateFormat.yMd(currentLocale).format(picked);
      });

      onDateSelected(picked);
    }
  }

  void onDateSelected(DateTime date) {
    // To be overridden by subclasses if needed
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
      onChanged: onEducationLevelChanged,
      validator: validateEducationLevelField,
      isExpanded: true,
    );
  }

  void onEducationLevelChanged(EducationLevel? value) {
    setState(() {
      selectedEducationLevel = value;
    });
  }

  String? validateEducationLevelField(EducationLevel? value) {
    return null;
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