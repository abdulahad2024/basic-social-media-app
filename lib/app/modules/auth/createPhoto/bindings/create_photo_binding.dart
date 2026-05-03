import 'package:get/get.dart';

import '../controllers/create_photo_controller.dart';

class CreatePhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreatePhotoController());
  }
}
