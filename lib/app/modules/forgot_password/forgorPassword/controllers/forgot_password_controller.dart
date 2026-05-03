import 'package:social_media_app/export.dart';

class ForgotPasswordController extends GetxController {


  final ForgotPasswordServices forgotPasswordServices =
      ForgotPasswordServices();

  final RxBool isLoading = false.obs;
  final emailController = TextEditingController();

  Future<void> forgotPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      AppUtils.showError("Please enter your email");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      AppUtils.showError("Please enter a valid email address");
      return;
    }

    try {
      isLoading.value = true;

      final response = await forgotPasswordServices.forgotPassword(email);

      if (response == null) {
        NetworkUtils.showNoInternetSnackbar();
        return;
      }

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        AppUtils.showSuccess("OTP sent successfully!");
        Get.toNamed(Routes.VERIFY_OTP, arguments: email);
      } else {
        String errorMsg = result['messages'] ?? "Failed to send OTP!";
        AppUtils.showError(errorMsg);
      }
    } catch (e) {
      debugPrint("Forgot Password Error: $e");
      AppUtils.showError("An unexpected error occurred. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }





}
