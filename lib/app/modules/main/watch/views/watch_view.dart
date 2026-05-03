import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/modules/main/watch/views/widgets/reel_video_item.dart';
import 'package:social_media_app/app/routes/app_pages.dart';
import '../controllers/watch_controller.dart';
import '../controllers/video_manager.dart';

class WatchView extends GetView<WatchController> {
  const WatchView({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemUI → immersive (TikTok style)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    final controller = Get.put(WatchController());

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Obx(() {
        // ── Loading ──────────────────────────────────────────
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
          );
        }

        // ── Empty ────────────────────────────────────────────
        if (controller.postList.isEmpty) {
          return const Center(
            child: Text(
              "No Videos Found",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }

        // postList.length capture — এটাই Obx track করবে
        final int count = controller.postList.length;

        return Stack(
          children: [

            PageView.builder(
              scrollDirection: Axis.vertical,
              allowImplicitScrolling: true,
              itemCount: count,
              onPageChanged: (index) {
                controller.changeIndex(index);
              },
              itemBuilder: (context, index) {
                final post = controller.postList[index];

                // ✅ Obx নেই — ReelVideoItem নিজেই activeIndex observe করে
                return ReelVideoItem(
                  key: ValueKey(post['id']),
                  index: index,
                  post: post,
                );
              },
            ),

            // ── TOP BAR ──────────────────────────────────────
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    const Text(
                      "For You",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.CREATE_POST);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}