import 'package:get/get.dart';

import '../controllers/view_story_controller.dart';

class ViewStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewStoryController>(
      () => ViewStoryController(),
    );
  }
}
