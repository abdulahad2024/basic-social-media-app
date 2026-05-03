import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoManager extends GetxController {
  // Tracks which index is currently active
  RxInt activeIndex = 0.obs;

  @override
  void onClose() {
    super.onClose();
  }
}