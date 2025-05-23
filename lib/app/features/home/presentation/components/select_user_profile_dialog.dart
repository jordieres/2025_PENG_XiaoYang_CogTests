import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/themes/AppColors.dart';
import '../../../../config/themes/app_text_style_base.dart';
import '../../../../config/translation/app_translations.dart';
import '../../../../shared_components/custom_dialog.dart';
import '../../../../shared_components/custom_secondary_button.dart';
import '../../../../utils/helpers/widget_max_width_calculator.dart';
import '../controllers/select_user_profile_controller.dart';

class SelectUserDialog extends StatefulWidget {
  final SelectUserController controller;
  final Function(String) onProfileSelected;

  const SelectUserDialog({
    super.key,
    required this.controller,
    required this.onProfileSelected,
  });

  @override
  State<SelectUserDialog> createState() => _SelectUserDialogState();
}

class _SelectUserDialogState extends State<SelectUserDialog> with WidgetsBindingObserver {
  late SearchController searchController;
  bool _isSearchOpen = false;
  bool _isKeyboardVisible = false;
  bool _isWaitingForKeyboardHide = false;
  Function? _pendingActionAfterKeyboardHide;

  @override
  void initState() {
    super.initState();
    searchController = SearchController();
    WidgetsBinding.instance.addObserver(this);
    _updateKeyboardVisibility();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (!_isSearchOpen) {
      searchController.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bool previousKeyboardVisibility = _isKeyboardVisible;
    _updateKeyboardVisibility();

    if (previousKeyboardVisibility && !_isKeyboardVisible && _isWaitingForKeyboardHide) {
      _pendingActionAfterKeyboardHide?.call();
      _isWaitingForKeyboardHide = false;
      _pendingActionAfterKeyboardHide = null;
    }
  }

  void _updateKeyboardVisibility() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final isVisible = bottomInset > 0;
    if (_isKeyboardVisible != isVisible && mounted) {
      setState(() {
        _isKeyboardVisible = isVisible;
      });
    } else {
      _isKeyboardVisible = isVisible;
    }
  }

  void _runAfterKeyboardHide(Function action) {
    FocusScope.of(context).unfocus();

    Future.delayed(Duration(milliseconds: 50), () {
      _updateKeyboardVisibility();
      if (!_isKeyboardVisible) {
        action();
      } else {
        _isWaitingForKeyboardHide = true;
        _pendingActionAfterKeyboardHide = action;
      }
    });
  }

  bool get _isLandscape =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  EdgeInsets get _listTilePadding => EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: _isLandscape ? 4.0 : 8.0,
  );

  EdgeInsets get _dialogPadding => EdgeInsets.all(_isLandscape ? 8.0 : 16.0);

  Widget _buildProfileListTile(dynamic profile, {bool isFromSearch = false}) {
    return InkWell(
      child: ListTile(
        dense: _isLandscape,
        contentPadding: _listTilePadding,
        title: Text(profile.nickname, style: TextStyleBase.bodyL),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          tooltip: SelectUserProfileDialogText.deleteButton.tr,
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();

            _confirmDeleteProfile(context, profile.userId, profile.nickname,
                isFromSearch: isFromSearch);
          },
        ),
        onTap: () => _handleProfileSelection(profile.userId, isFromSearch),
      ),
    );
  }

  void _handleProfileSelection(String userId, bool isFromSearch) {
    if (isFromSearch) {
      Get.back();
      if (mounted) {
        widget.onProfileSelected(userId);
        Get.back();
      }
    } else {
      widget.onProfileSelected(userId);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = WidgetMaxWidthCalculator.getMaxWidth(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final heightConstraint =
    _isLandscape ? screenHeight * 0.9 : screenHeight * 0.8;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: _isLandscape ? 12 : 24,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: heightConstraint,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24.0, bottom: 16.0),
              child: Text(
                SelectUserProfileDialogText.title.tr,
                style: TextStyleBase.h3,
              ),
            ),
            Expanded(
              child: _buildProfileList(),
            ),
            Padding(
              padding: _dialogPadding,
              child: SizedBox(
                width: double.infinity,
                child: CustomSecondaryButton(
                  text: SelectUserProfileDialogText.cancelButton.tr,
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

  Widget _buildProfileList() {
    return Obx(() {
      if (widget.controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else {
        return ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildSearchAnchor(),
            ),
            SizedBox(height: 16),
            if (widget.controller.profiles.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    SelectUserProfileDialogText.noProfiles.tr,
                    style: TextStyleBase.bodyL,
                  ),
                ),
              )
            else
              ...widget.controller.profiles.map((profile) {
                return Column(
                  children: [
                    _buildProfileListTile(profile),
                    if (profile != widget.controller.profiles.last)
                      Divider(
                        height: 1,
                        color: AppColors.userProfileDividerColor,
                      ),
                  ],
                );
              }).toList(),
          ],
        );
      }
    });
  }

  Widget _buildSearchAnchor() {
    return SearchAnchor(
      searchController: searchController,
      isFullScreen: true,
      builder: (BuildContext context, SearchController controller) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _isSearchOpen = true;
            });
            controller.openView();
          },
          child: InkWell(
            onTap: () {
              setState(() {
                _isSearchOpen = true;
              });
              controller.openView();
            },
            borderRadius: BorderRadius.circular(28),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  width: 2,
                  color: AppColors.getPrimaryBlueDependIsDarkMode(),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      SelectUserProfileDialogText.searchAnchorSearchBarHint.tr,
                      style: TextStyleBase.bodyL.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewOnChanged: (value) {
      },
      viewBuilder: (suggestions) {
        _isSearchOpen = true;
        return ListView(
          children: suggestions.toList(),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        final query = controller.text.toLowerCase();

        if (query.isEmpty) {
          return [];
        }

        final filteredProfiles = widget.controller.profiles
            .where((profile) => profile.nickname.toLowerCase().contains(query))
            .toList();

        if (filteredProfiles.isEmpty) {
          return [
            ListTile(
              title: Text(
                SelectUserProfileDialogText.searchAnchorSearchBarNotFound.tr,
                style: TextStyleBase.bodyL,
              ),
            )
          ];
        }

        return filteredProfiles.map((profile) {
          return _buildProfileListTile(profile, isFromSearch: true);
        }).toList();
      },
    );
  }

  void _confirmDeleteProfile(
      BuildContext context, String userId, String nickname,
      {bool isFromSearch = false}) {
    _runAfterKeyboardHide(() {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomDialog(
            title: SelectUserProfileDialogText.deleteConfirmTitle.tr,
            content: SelectUserProfileDialogText.deleteConfirmContent.tr
                .replaceAll('{user}', nickname),
            mode: DialogMode.confirmCancel,
            primaryButtonText: SelectUserProfileDialogText.deleteButton.tr,
            cancelButtonText: SelectUserProfileDialogText.cancelDeleteButton.tr,
            onPrimaryPressed: () async {
              Navigator.of(dialogContext).pop();

              if (!mounted) return;
              await widget.controller.deleteProfile(userId);

              if (isFromSearch && mounted) {
                final currentQuery = searchController.text;
                searchController.text = '';
                await Future.delayed(Duration(milliseconds: 50));
                if (mounted) {
                  searchController.text = currentQuery;
                }
              }
            },
            onCancelPressed: () {
              Navigator.of(dialogContext).pop();
            },
          );
        },
      );
    });
  }
}