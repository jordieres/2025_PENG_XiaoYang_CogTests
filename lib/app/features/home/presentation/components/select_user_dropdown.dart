import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/config/themes/app_text_style_base.dart';
import 'package:msdtmt/app/features/home/presentation/components/select_user_profile_dialog.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/routes/app_route_observer.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../../../../utils/helpers/widget_max_width_calculator.dart';
import '../controllers/select_user_profile_controller.dart';

class SelectUserDropdown extends StatefulWidget {
  const SelectUserDropdown({super.key});

  @override
  State<StatefulWidget> createState() => SelectUserDropdownState();
}

class SelectUserDropdownState extends State<SelectUserDropdown>
    with NavigationMixin {
  Worker? _routeObserverWorker;
  late SelectUserController _controller;

  final BoxDecoration _boxDecoration = BoxDecoration(
    border: Border.all(
      color: AppColors.getPrimaryBlueDependIsDarkMode(),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(8),
  );

  final BorderRadius _borderRadius = BorderRadius.circular(8);
  final EdgeInsets _containerPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  @override
  void initState() {
    super.initState();
    _controller = Get.find<SelectUserController>();
    _routeChangeObserver();
  }

  void _routeChangeObserver() {
    _routeObserverWorker = ever(appRouteObserver.currentRouteName, (routeName) {
      if (routeName == Routes.home) {
        _controller.refreshAfterUserRegistration();
      }
    });
  }

  @override
  void dispose() {
    _routeObserverWorker?.dispose();
    super.dispose();
  }

  void _showSelectUserDialog() {
    if (_controller.currentProfile.value == null) {
      Get.toNamed(Routes.register_user);
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SelectUserDialog(
          controller: _controller,
          onProfileSelected: (userId) {
            _controller.setCurrentProfile(userId);
          },
        );
      },
    );
  }

  Widget _buildDropDownIcon() {
    return Icon(
      Icons.arrow_drop_down,
      color: AppColors.getPrimaryBlueDependIsDarkMode(),
      size: 28,
    );
  }

  Widget _buildCreateUserWidget() {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: _boxDecoration,
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: () {
            toRegisterUser();
          },
          child: Padding(
            padding: _containerPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  SelectUserDropdownText.createUser.tr,
                  style: TextStyleBase.h2.copyWith(
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                _buildDropDownIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileWidget(dynamic profile) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;

          final greetingText = Text(
            SelectUserDropdownText.greeting.tr,
            style: TextStyleBase.h1,
          );

          final textSpan = TextSpan(
            text: SelectUserDropdownText.greeting.tr,
            style: TextStyleBase.h1,
          );
          final textPainter = TextPainter(
            text: textSpan,
            textDirection: TextDirection.ltr,
            maxLines: 1,
          )..layout();

          final greetingWidth = textPainter.width + 16;

          final nameWidth = totalWidth - greetingWidth;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              greetingText,
              const SizedBox(width: 8),
              Container(
                constraints: BoxConstraints(maxWidth: nameWidth*0.9),
                child: InkWell(
                  onTap: _showSelectUserDialog,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          profile.nickname,
                          style: TextStyleBase.h2.copyWith(
                            color: AppColors.getPrimaryBlueDependIsDarkMode(),
                          ),
                          softWrap: true,
                        ),
                      ),
                      _buildDropDownIcon(),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = WidgetMaxWidthCalculator.getMaxWidth(context);

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Obx(() {
        final profile = _controller.currentProfile.value;
        return profile == null
            ? _buildCreateUserWidget()
            : _buildUserProfileWidget(profile);
      }),
    );
  }
}