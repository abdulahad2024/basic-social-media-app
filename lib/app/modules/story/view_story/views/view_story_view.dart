import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/modules/profile/profiles/controllers/profiles_controller.dart';
import 'package:social_media_app/app/routes/app_pages.dart';
import 'package:story_view/story_view.dart';
import '../../../../utils/api_url/api_url.dart';
import '../../../../data/model/story_model.dart';
import '../controllers/view_story_controller.dart';

class ViewStoryView extends GetView<ViewStoryController> {
  // কনস্ট্রাক্টর থেকে লিস্ট রিসিভ
  final List<StoryModel> stories;
  const ViewStoryView({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {

    controller.initializeStories(stories);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (!controller.isInitialized.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }

        return Stack(
          children: [
            // স্টোরি প্লেয়ার
            StoryView(
              storyItems: controller.storyItems,
              controller: controller.storyController,
              onComplete: () => Get.back(),
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) Get.back();
              },
            ),

            Positioned(
              top: 60,
              left: 20,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.USER_PROFILE,arguments: stories.first.userId);
                      print(stories.first.id.toString());
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[800],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // সার্কেল শেপ ঠিক রাখার জন্য
                        child: Image.network(
                          ApiUrl.imageUrl + (stories.first.userProfile ?? ""),
                          width: 40, // radius * 2
                          height: 40,
                          fit: BoxFit.cover,

                          // ইমেজ লোড হওয়ার সময় যা দেখাবে
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              ),
                            );
                          },

                          // ইমেজ লোড হতে এরর হলে (যেমন ৪-৪ বা নেটওয়ার্ক ইস্যু) যা দেখাবে
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child:  Image.network("https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png"),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stories.first.userName ?? "User",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Stack-এর ভেতর একদম শেষে এই Positioned উইজেটটি যোগ করুন
            // Stack-এর ভেতর ডিলিট বাটনের অংশটি এভাবে পরিবর্তন করুন:

            // যদি স্টোরিটি লগইন করা ইউজারের হয়, তবেই ডিলিট বাটন দেখাবে
            if (stories.first.userId == Get.find<ProfilesController>().profile['id'])
              Positioned(
                top: 55,
                right: 50,
                child: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Delete Story?",
                      middleText: "Are you sure you want to delete this story?",
                      textConfirm: "Yes, Delete",
                      textCancel: "No",
                      buttonColor: Colors.red,
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        Get.back(); // ডায়ালগ ক্লোজ
                        controller.deleteStory(stories.first.id);
                      },
                    );
                  },
                ),
              ),

            // ক্লোজ বাটন
            Positioned(
              top: 55,
              right: 15,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        );
      }),
    );
  }
}