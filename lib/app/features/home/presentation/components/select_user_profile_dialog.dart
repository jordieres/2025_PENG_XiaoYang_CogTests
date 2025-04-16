import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msdtmt/app/shared_components/custom_primary_button.dart';
import '../../../../shared_components/custom_dialog.dart';
import '../../domain/usecases/home_reference_select_user_width_calculator.dart';
import '../controllers/select_user_profile_controller.dart';

class SelectUserDialog extends StatelessWidget {
  final SelectUserController controller;
  final Function(String) onProfileSelected;

  const SelectUserDialog({
    super.key,
    required this.controller,
    required this.onProfileSelected,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = HomeReferenceSelectUserWidthCalculator.getMaxWidth(context);
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 24),
            Text(
              'Seleccionar perfil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 42),
            Divider(height: 1),
            Obx(() {
              if (controller.isLoading.value) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (controller.profiles.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('No hay perfiles disponibles'),
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.profiles.length,
                  separatorBuilder: (context, index) => Divider(height: 1),
                  itemBuilder: (context, index) {
                    final profile = controller.profiles[index];
                    return ListTile(
                      title: Text(profile.nickname),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _confirmDeleteProfile(
                              context, profile.userId, profile.nickname);
                        },
                      ),
                      onTap: () {
                        onProfileSelected(profile.userId);
                        Get.back();
                      },
                    );
                  },
                );
              }
            }),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: CustomPrimaryButton(
                  text: 'Cancel',
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteProfile(
      BuildContext context, String userId, String nickname) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Eliminar perfil',
          content: '¿Está seguro que desea eliminar el perfil "$nickname"?',
          mode: DialogMode.confirmCancel,
          primaryButtonText: 'Eliminar',
          cancelButtonText: 'Cancelar',
          onPrimaryPressed: () {
            controller.deleteProfile(userId);
            Get.back();
          },
          onCancelPressed: () {
            Get.back();
          },
        );
      },
    );
  }
}