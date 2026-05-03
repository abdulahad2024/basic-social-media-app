import 'package:social_media_app/export.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final emailPhoneController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthServices authServices = AuthServices();
  final AuthSession authSession = AuthSession();

  Future<void> login() async {

    if (emailPhoneController.text.isEmpty || passwordController.text.isEmpty) {
      AppUtils.showWarning("Fill in all the boxes!");
      return;
    }

    isLoading.value = true;

    try {
      final data = {
        'login': emailPhoneController.text.trim(),
        'password': passwordController.text,
      };

      final response = await authServices.login(data);

      if (response == null) {
        NetworkUtils.showNoInternetSnackbar();
      } else {
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
          String token = result['token'].toString();
          await authSession.saveToken(token);
          AppUtils.showSuccess("Login successful!");
          Get.offAllNamed(Routes.HOME);
        } else {
          String errorMsg = result['messages'] ?? "Login failed!";
          AppUtils.showError(errorMsg);
        }
      }
    } catch (e) {
      debugPrint("Login Error: $e");
      AppUtils.showError("There was an error! Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailPhoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
