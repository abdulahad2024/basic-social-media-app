import 'package:social_media_app/export.dart';

class CreatePasswordController extends GetxController {
  final isLoading = false.obs;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final AuthServices authServices = AuthServices();

  Future<void> createPassword() async {
    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      AppUtils.showWarning("Fill in all the boxes!");
      return;
    }
    if (passwordController.text.length < 8 ||
        confirmPasswordController.text.length < 8) {
      AppUtils.showWarning("Password must be at least 8 characters!");
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      AppUtils.showWarning("Passwords do not match!");
      return;
    }
    isLoading.value = true;

    try {
      final data = {
        'password': passwordController.text.trim(),
        'new_password_confirmation': confirmPasswordController.text.trim(),
      };

      final response = await authServices.personalInfo(data);

      if (response == null) {
        NetworkUtils.showNoInternetSnackbar();
      } else {
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          Get.toNamed(Routes.CREATE_PHOTO);
        } else {
          String errorMsg =
              result['messages'] ?? "Failed to save personal info!";
          AppUtils.showError(errorMsg);
        }
      }
    } catch (e) {
      debugPrint("Personal Info Error: $e");
      AppUtils.showError("There was an error! Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
