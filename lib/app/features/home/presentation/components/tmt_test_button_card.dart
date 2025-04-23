import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/config/themes/AppColors.dart';
import 'package:msdtmt/app/constans/app_constants.dart';
import 'package:msdtmt/app/shared_components/custom_dialog.dart';
import 'package:msdtmt/app/utils/mixins/app_mixins.dart';

import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../tm_tst/domain/usecases/tmt_game_config_use_case.dart';
import '../../domain/entities/home_ui_constant_variable.dart';

enum CircleNumberOption {
  twentyFive(25),
  fifteen(15);

  final int value;

  const CircleNumberOption(this.value);

  static CircleNumberOption fromValue(int value) {
    return CircleNumberOption.values.firstWhere(
      (option) => option.value == value,
      orElse: () => twentyFive,
    );
  }
}

class TmtTestButtonCard extends StatefulWidget {
  final String referenceCode;
  final VoidCallback? onStartTest;

  const TmtTestButtonCard({
    super.key,
    required this.referenceCode,
    this.onStartTest,
  });

  @override
  State<TmtTestButtonCard> createState() => _TmtTestButtonCardState();
}

class _TmtTestButtonCardState extends State<TmtTestButtonCard>
    with NavigationMixin {
  CircleNumberOption selectedCircleNumber = CircleNumberOption.twentyFive;
  final controller = TextEditingController();
  final focusNode = FocusNode();
  late TmtGameConfigUseCase tmtGameConfigUseCase;

  @override
  void initState() {
    super.initState();
    tmtGameConfigUseCase = Get.find<TmtGameConfigUseCase>();
    tmtGameConfigUseCase.getCircleNumber().then((value) {
      selectedCircleNumber = CircleNumberOption.fromValue(value);
      controller.text = selectedCircleNumber.value.toString();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isActive = widget.referenceCode.isNotEmpty;

    return Stack(
      children: [
        Card(
          elevation: 0,
          color: isDarkMode
              ? AppColors.secondaryBlueClearDark
              : AppColors.secondaryBlueClear,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(HomeUIConstantVariable.cardCornerRadius),
          ),
          child: Opacity(
            opacity: HomeUIConstantVariable.getOpacityDependIsEnable(isActive),
            child: SizedBox(
              height: HomeUIConstantVariable.tmtTestButtonCardHeight,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildStartTestButton(context, isDarkMode, isActive),
                  ),
                  Expanded(
                    flex: 1,
                    child: _buildCircleNumberSelector(
                        context, isDarkMode, isActive),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isActive) HomeUIConstantVariable.lockIconWidget,
      ],
    );
  }

  Widget _buildStartTestButton(
      BuildContext context, bool isDarkMode, bool isActive) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(HomeUIConstantVariable.cardCornerRadius),
      child: Material(
        color:
            isDarkMode ? AppColors.secondaryBlueDark : AppColors.secondaryBlue,
        child: InkWell(
          splashColor: isDarkMode
              ? Colors.white.withAlpha(51)
              : AppColors.getPrimaryBlueColor().withAlpha(51),
          highlightColor: isDarkMode
              ? Colors.white.withAlpha(25)
              : AppColors.getPrimaryBlueColor().withAlpha(25),
          onTap: isActive
              ? () {
                  if (widget.onStartTest != null) {
                    widget.onStartTest!();
                  } else {
                    toSelectedPracticeOrTest(widget.referenceCode);
                  }
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: HomeUIConstantVariable.cardHorizontalPadding),
            child: Center(
              child: Text(TmtTestButtonCardText.startTest.tr,
                  textAlign: TextAlign.center,
                  style: TextStyleBase.h2.copyWith(
                    color: isDarkMode ? AppColors.darkText : AppColors.blueText,
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleNumberSelector(
      BuildContext context, bool isDarkMode, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(TmtTestButtonCardText.numberOfCircles.tr,
              textAlign: TextAlign.center,
              style: TextStyleBase.h4.copyWith(
                color: isDarkMode ? AppColors.darkText : AppColors.blueText,
              )),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child:
                    _buildCircleNumberDropdown(context, isDarkMode, isActive),
              ),
              const SizedBox(width: 8),
              _buildHelpButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleNumberDropdown(
      BuildContext context, bool isDarkMode, bool isActive) {
    final primaryColor =
        AppColors.getPrimaryBlueDependIsDarkMode(isDarkMode: isDarkMode);

    return SizedBox(
      height: 46,
      child: Stack(
        children: [
          Container(
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  HomeUIConstantVariable.cardCornerRadius),
              border: Border.all(color: primaryColor, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Text(
                    selectedCircleNumber.value.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: DropdownMenu<CircleNumberOption>(
              enabled: isActive,
              controller: controller,
              focusNode: focusNode,
              initialSelection: selectedCircleNumber,
              expandedInsets: EdgeInsets.zero,
              textStyle: TextStyle(
                fontSize: 16,
                color: Colors.transparent,
              ),
              leadingIcon: SizedBox.shrink(),
              trailingIcon: Icon(
                Icons.arrow_drop_down,
                color: primaryColor,
                size: 24,
              ),
              selectedTrailingIcon: Icon(
                Icons.arrow_drop_up,
                color: primaryColor,
                size: 24,
              ),
              inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      HomeUIConstantVariable.cardCornerRadius),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      HomeUIConstantVariable.cardCornerRadius),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      HomeUIConstantVariable.cardCornerRadius),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                filled: false,
              ),
              menuStyle: MenuStyle(
                elevation: WidgetStateProperty.all(8),
                backgroundColor: WidgetStateProperty.all(
                  isDarkMode ? AppColors.darkSurface : Colors.white,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        HomeUIConstantVariable.cardCornerRadius),
                    side: BorderSide(color: primaryColor, width: 2),
                  ),
                ),
              ),
              onSelected: isActive
                  ? (CircleNumberOption? option) {
                      if (option != null) {
                        setState(() {
                          selectedCircleNumber = option;
                          _tmtNumBerCircleConfig(selectedCircleNumber);
                          controller.text = option.value.toString();
                        });
                      }
                    }
                  : null,
              dropdownMenuEntries: CircleNumberOption.values
                  .map<DropdownMenuEntry<CircleNumberOption>>(
                (CircleNumberOption option) {
                  return DropdownMenuEntry<CircleNumberOption>(
                    value: option,
                    label: option.value.toString(),
                    style: MenuItemButton.styleFrom(
                      textStyle: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black87,
                        fontSize: 16,
                      ),
                      alignment: Alignment.center,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpButton(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: isDarkMode
              ? Colors.white.withAlpha(51)
              : AppColors.getPrimaryBlueColor().withAlpha(51),
          onTap: () => _showCircleNumberInfoDialog(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isDarkMode
                ? SvgPicture.asset(
                    ImageVectorPath.help,
                    width: 30,
                    height: 30,
                    colorFilter: const ColorFilter.mode(
                      AppColors.darkText,
                      BlendMode.srcIn,
                    ),
                  )
                : SvgPicture.asset(
                    ImageVectorPath.help,
                    width: 30,
                    height: 30,
                  ),
          ),
        ),
      ),
    );
  }

  void _showCircleNumberInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: TmtTestButtonCardText.dialogTitle.tr,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(TmtTestButtonCardText.chooseBetween.tr),
              const SizedBox(height: 8),
              _buildBulletPoint(TmtTestButtonCardText.completeTest.tr),
              _buildBulletPoint(TmtTestButtonCardText.simplifiedVersion.tr),
              const SizedBox(height: 16),
              Text(TmtTestButtonCardText.consultNeurologist.tr,
                  style: TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
          mode: DialogMode.confirmCancel,
          primaryButtonText: TmtTestButtonCardText.understood.tr,
          cancelButtonText: TmtTestButtonCardText.cancel.tr,
          onPrimaryPressed: () {
            Navigator.of(context).pop();
          },
          onCancelPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  _tmtNumBerCircleConfig(CircleNumberOption circleNumberOption) async {
    await tmtGameConfigUseCase.saveCircleNumber(circleNumberOption.value);
  }
}
