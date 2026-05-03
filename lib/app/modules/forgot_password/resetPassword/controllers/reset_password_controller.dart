import 'package:social_media_app/export.dart';

class ResetPasswordController extends GetxController {
  var isLoading = false.obs;
  String? email;
  String? otp;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ForgotPasswordServices forgotPasswordServices =
      ForgotPasswordServices();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() {
    email = Get.arguments['email'];
    otp = Get.arguments['otp'];
  }

  Future<void> resetPassword() async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password.isEmpty) {
      AppUtils.showError("Please enter your password");
      return;
    }

    if (confirmPassword.isEmpty) {
      AppUtils.showError("Please confirm your password");
      return;
    }

    try {
      isLoading.value = true;

      var data = {
        "email": email,
        "otp": otp,
        "password": password,
        "password_confirmation": confirmPassword,
      };

      final response = await forgotPasswordServices.resetPassword(data);

      if (response == null) {
        NetworkUtils.showNoInternetSnackbar();
        return;
      }

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        AppUtils.showSuccess("Password reset successfully!");
        Get.offAllNamed(Routes.LOGIN);
        passwordController.clear();
        confirmPasswordController.clear();
        isLoading.value = false;
      } else {
        String errorMsg = result['messages'] ?? "Failed to reset password!";
        AppUtils.showError(errorMsg);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint("Reset Password Error: $e");
      AppUtils.showError("An unexpected error occurred. Please try again.");
    }
  }

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

}
