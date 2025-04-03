part of ui_utils;

/// contains all snackbar templates
class AppSnackbar {
  static void showCustomSnackbar(
    BuildContext context,
    String message, {
    int durationInSeconds = 2,
    Color backgroundColor = Colors.black87,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
        duration: Duration(seconds: durationInSeconds),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.2, // 20% padding on both sides
          vertical: 12,
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
