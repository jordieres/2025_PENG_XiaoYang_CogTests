import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/themes/AppColors.dart';
import '../config/themes/AppTextStyle.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final VoidCallback? onPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(
        title,
        style: AppTextStyle.appBarTitle,
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onPressed ?? () => Get.back(),
        color: AppColors.primaryBlue,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}