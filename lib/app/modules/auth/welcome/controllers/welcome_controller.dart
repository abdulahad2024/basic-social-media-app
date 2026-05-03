import 'package:social_media_app/export.dart';

class WelcomeController extends GetxController {

  late ConfettiController confettiController;

  @override
  void onInit() {
    super.onInit();
    confettiController = ConfettiController(duration: const Duration(seconds: 3));

    confettiController.play();

    Timer(const Duration(seconds: 5), () {
      Get.offAllNamed(Routes.HOME);
    });
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }
}