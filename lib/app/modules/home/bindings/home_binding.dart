import 'package:get/get.dart';

import '../../main/main/controllers/main_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<MainController>(() => MainController());
  }
}
