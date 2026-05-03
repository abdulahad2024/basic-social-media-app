import 'package:social_media_app/export.dart';

class AppUtils {
  // Success SnackBar
  static void showSuccess(String message) {
    _showGetXSnackBar(
      title: "Success!",
      message: message,
      backColor: const Color(0xFF00B09B),
      icon: Icons.check_circle_outline_rounded,
    );
  }

  // Error SnackBar
  static void showError(String message) {
    _showGetXSnackBar(
      title: "Oops!",
      message: message,
      backColor: const Color(0xFFFF5F6D),
      icon: Icons.error_outline_rounded,
    );
  }

  // Warning SnackBar
  static void showWarning(String message) {
    _showGetXSnackBar(
      title: "Note",
      message: message,
      backColor: AppColors.primary600,
      icon: Icons.warning_amber_rounded,
    );
  }

  static void _showGetXSnackBar({
    required String title,
    required String message,
    required Color backColor,
    required IconData icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backColor.withValues(alpha: 0.9),
      colorText: Colors.white,
      icon: Icon(icon, color: Colors.white, size: 28),
      margin: const EdgeInsets.all(15),
      borderRadius: 15,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.fastOutSlowIn,

      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 10,
          offset: const Offset(0, 5),
        )
      ],
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Icon(Icons.close, color: Colors.white, size: 20),
      ),
    );
  }
}