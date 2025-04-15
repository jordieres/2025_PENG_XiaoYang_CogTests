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

    Get.snackbar(
      '',
      '',
      titleText: Container(),
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
        horizontal: Get.width * 0.1,
        vertical: 20,
      ),
      borderRadius: 10,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCirc,
    ).future.then((_) {
      _isSnackbarVisible = false;
    });
  }
}