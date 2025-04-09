part of ui_utils;

/// contains all snackbar templates
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
    final screenWidth = MediaQuery.of(context).size.width;

    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.onInverseSurface),
              ),
            ),
            duration: Duration(seconds: durationInSeconds),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1, // 20% padding on both sides
              vertical: 20,
            ),
            backgroundColor: backgroundColor,
          ),
        )
        .closed
        .then((_) {
      _isSnackbarVisible = false;
    });
  }
}
