import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/features/home/presentation/components/select_user_profile_dialog.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../config/routes/app_route_observer.dart';
import '../../domain/usecases/home_reference_select_user_width_calculator.dart';
import '../controllers/select_user_profile_controller.dart';

class SelectUserDropdown extends StatefulWidget {
  const SelectUserDropdown({super.key});

  @override
  State<StatefulWidget> createState() => SelectUserDropdownState();
}

class SelectUserDropdownState extends State<SelectUserDropdown> {
  Worker? _routeObserverWorker;
  late SelectUserController _controller;

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

  @override
  Widget build(BuildContext context) {
    final maxWidth = HomeReferenceSelectUserWidthCalculator.getMaxWidth(context);
    
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Obx(() {
        final profile = _controller.currentProfile.value;

        if (profile == null) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.register_user);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Crear usuario",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          );
        } else {
          return Row(
            children: [
              Text(
                "Hola, ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: _showSelectUserDialog,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          profile.nickname,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}