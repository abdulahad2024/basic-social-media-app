import 'package:social_media_app/export.dart';

class OtpController extends GetxController {
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();

  String get otpCode => c1.text + c2.text + c3.text + c4.text;

  var phoneNumber = "".obs;
  final isLoading = false.obs;
  final authServices = AuthServices();

  RxInt timerSeconds = 60.obs;
  Timer? _timer;
  var isResendAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();
    phoneNumber.value = Get.arguments?.toString() ?? "";
    startTimer();
  }

  void startTimer() {
    timerSeconds.value = 60;
    isResendAvailable.value = false;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

  Future<void> verifyOtp() async {
    if (otpCode.length != 4) {
      AppUtils.showWarning("Please enter a valid OTP!");
      return;
    }

    isLoading.value = true;

    final otp = otpCode;

    final data = {'phone': phoneNumber.value, 'otp': otp};

    try {
      final response = await authServices.verifyOtp(data);

      if (response == null) {
        NetworkUtils.showNoInternetSnackbar();
      } else {
        final result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          AppUtils.showSuccess("OTP verified successfully!");
          Get.toNamed(Routes.PERSONAL_INFO);
          c1.clear();
          c2.clear();
          c3.clear();
          c4.clear();
        } else {
          String errorMsg = result['messages'] ?? "Failed to verified OTP!";
          AppUtils.showError(errorMsg);
        }
      }
    } catch (e) {
      debugPrint("OTP Verify Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    try {
      isLoading.value = true;

      final data = {'phone': phoneNumber.value};

      final response = await authServices.resendOtp(data);
      if (response == null) {
        NetworkUtils.showNoInternetSnackbar();
      } else {
        final result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          AppUtils.showSuccess("OTP resent successfully!");
          startTimer();
        } else {
          String errorMsg = result['messages'] ?? "Failed to resend OTP!";
          AppUtils.showError(errorMsg);
        }
      }
    } catch (e) {
      debugPrint("OTP Resend Error: $e");
      AppUtils.showError("Failed to resend OTP!");
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
    _timer?.cancel();
    super.onClose();
  }
}
