import 'package:social_media_app/export.dart';
class PhoneController extends GetxController {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  final AuthServices authServices = AuthServices();
  final AuthSession authSession = AuthSession();

  Future<void> otpSend() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final phone = phoneController.text.trim();
    isLoading.value = true;

    try {
      final data = {
        'phone': phone,
      };

      final response = await authServices.sendOtp(data);

      if (response == null) {
        NetworkUtils.showNoInternetSnackbar();
        return;
      }

      final result = jsonDecode(response.body);
      debugPrint("Response Body: $result");

      if (response.statusCode == 200) {
        String token = result['token'].toString();
        await authSession.saveToken(token);

        AppUtils.showSuccess(result['messages'] ?? "OTP sent successfully!");
        Get.toNamed(Routes.OTP, arguments: phone);

      } else if (response.statusCode == 422) {
        String errorMsg = result['errors'] ?? result['messages'] ?? "Validation error!";
        AppUtils.showError(errorMsg);

      } else {
        String errorMsg = result['messages'] ?? "Failed to send OTP!";
        AppUtils.showError(errorMsg);
      }

    } catch (e) {
      debugPrint("OTP Send Error: $e");
      AppUtils.showError("An unexpected error occurred!");
    } finally {
      isLoading.value = false;
    }
  }
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!value.startsWith('0')) {
      return 'Phone number must start with 0';
    }
    if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
      if (value.length < 11) {
        return 'Phone number must be 11 digits';
      } else if (value.length > 11) {
        return 'Phone number cannot exceed 11 digits';
      }
      return 'Invalid characters found';
    }
    return null;
  }



  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}