import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/config/themes/app_text_style_base.dart';
import 'package:msdtmt/app/features/home/presentation/components/select_user_profile_dialog.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/routes/app_route_observer.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../utils/mixins/app_mixins.dart';
import '../../domain/usecases/home_reference_select_user_width_calculator.dart';
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
    return Row(
      children: [
        Text(
          SelectUserDropdownText.greeting.tr,
          style: TextStyleBase.h2,
        ),
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: _boxDecoration,
              child: InkWell(
                borderRadius: _borderRadius,
                onTap: _showSelectUserDialog,
                child: Padding(
                  padding: _containerPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        profile.nickname,
                        style: TextStyleBase.h2,
                      ),
                      _buildDropDownIcon(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = HomeReferenceSelectUserWidthCalculator.getMaxWidth(context);

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