import 'package:get/get.dart';

import '../controllers/edu_info_controller.dart';

class EduInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EduInfoController());
  }
}
