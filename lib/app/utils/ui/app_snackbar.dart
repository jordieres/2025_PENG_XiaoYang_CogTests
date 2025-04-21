part of ui_utils;

class AppSnackbar {
  static bool _isSnackbarVisible = false;

  static void showCustomSnackbar(
    BuildContext context,
    String message, {
    int durationInSeconds = 2,
    Color? backgroundColor,
  }) {
    if (_isSnackbarVisible) {
      return;
    }

    backgroundColor ??= Theme.of(context).colorScheme.inverseSurface;
    _isSnackbarVisible = true;

    final maxWidth = WidgetMaxWidthCalculator.getMaxWidth(context);
    final horizontalMargin = (Get.width - maxWidth) / 2;
    final safeHorizontalMargin = horizontalMargin > 0 ? horizontalMargin : 0.0;

    Get.showSnackbar(
      GetSnackBar(
        messageText: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
          ),
        ),
        duration: Duration(seconds: durationInSeconds),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        margin: EdgeInsets.symmetric(
          horizontal: safeHorizontalMargin,
          vertical: 20,
        ),
        borderRadius: 10,
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutCirc,
        onTap: (_) {
          Get.closeCurrentSnackbar();
        },
      ),
    ).future.then((_) {
      _isSnackbarVisible = false;
    });
  }
}
