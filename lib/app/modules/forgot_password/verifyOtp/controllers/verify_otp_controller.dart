import 'package:social_media_app/export.dart';

class VerifyOtpController extends GetxController {

  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();

  String get otpCode => c1.text + c2.text + c3.text + c4.text;

  var isLoading = false.obs;
  String? email;

  final ForgotPasswordServices forgotPasswordServices =
      ForgotPasswordServices();

  RxInt timerSeconds = 60.obs;
  Timer? _timer;
  var isResendAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments ?? '';
    if (email == null) {
      debugPrint("Warning: Email argument is null!");
    }
    startTimer();
  }

  Future<void> verifyOtp() async {
    if (otpCode.length < 4) {
      AppUtils.showError("Please enter the full 4-digit code");
      return;
    }

    try {
      isLoading.value = true;

      final response = await forgotPasswordServices.verifyResetOtp(
        email!,
        otpCode,
      );

      if (response == null) {
        NetworkUtils.showNoInternetSnackbar();
        return;
      }

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        AppUtils.showSuccess("OTP verified successfully!");

        Get.toNamed(
          Routes.RESET_PASSWORD,
          arguments: {'email': email, 'otp': otpCode},
        );
      } else {
        String errorMsg = result['messages'] ?? "Failed to Verify OTP!";
        AppUtils.showError(errorMsg);
      }
    } catch (e) {
      debugPrint("OTP Verify Error: $e");
      String finalError = e.toString().replaceAll("Exception: ", "");
      AppUtils.showError(finalError);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (email == null) return;

    try {
      isLoading.value = true;
      final response = await forgotPasswordServices.resendOtp(email!);
      if (response?.statusCode == 200) {
        AppUtils.showSuccess("A new OTP has been sent!");
      }
    } catch (e) {
      AppUtils.showError("Failed to resend OTP");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
    super.onClose();
  }

  void startTimer() {
    timerSeconds.value = 60;
    isResendAvailable.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        isResendAvailable.value = true;
        _timer?.cancel();
      }
    });
  }

  String get timerText {
    int minutes = timerSeconds.value ~/ 60;
    int seconds = timerSeconds.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
