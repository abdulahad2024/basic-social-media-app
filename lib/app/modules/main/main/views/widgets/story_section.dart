import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social_media_app/app/modules/profile/profiles/controllers/profiles_controller.dart';
import 'package:social_media_app/app/routes/app_pages.dart';
import '../../../../../data/model/story_model.dart';
import '../../../../../utils/api_url/api_url.dart';
import '../../controllers/main_controller.dart';
import '../shimmer/story_shimmer.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Obx(() {
        if (controller.isLoading.value) {
          return StoryShimmer();
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.storyGroups.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildCreateStoryCard();
            }
            return _buildStoryCard(controller.storyGroups[index - 1]);
          },
        );
      }),
    );
  }

  Widget _buildStoryCard(StoryGroup group) {
    final firstStory = group.stories.first;
    final String mediaUrl = ApiUrl.imageUrl + firstStory.mediaUrl;
    final String userImg = ApiUrl.imageUrl + (firstStory.userProfile ?? "");

    return GestureDetector(
      onTap: () async {
        // result রিসিভ করা
        var result = await Get.toNamed(Routes.VIEW_STORY, arguments: group.stories);

        // যদি result true হয়, তবে হোম পেজের ডাটা পুনরায় লোড করুন
        if (result == true) {
          Get.find<MainController>().getStories(); // আপনার স্টোরি লোড করার ফাংশনটি কল করুন
        }
      },
      child: Container(
        width: 110,
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: CachedNetworkImageProvider(mediaUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // প্রোফাইল ছবি উইথ নীল বর্ডার
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.grey[200], // ইমেজ লোড না হওয়া পর্যন্ত এই ব্যাকগ্রাউন্ড দেখাবে
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Image.network(
                      userImg,
                      width: 34,
                      height: 34,
                      fit: BoxFit.cover,
                      // ইমেজ লোড হওয়ার সময় (Loading indicator)
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      // ইমেজ লোড হতে ব্যর্থ হলে (Error handling)
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Image.network("https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png"),
                        );
                      },
                    ),
                  ),
                )
              ),
            ),
            // ইউজারের নাম
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                firstStory.userName ?? "User",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildCreateStoryCard() {

    final controller = Get.put(ProfilesController());

    return Obx(() {


      String? profilePath = controller.profile['profile_image'];
      final String userImg = (profilePath != null && profilePath.isNotEmpty)
          ? ApiUrl.imageUrl + profilePath
          : "";

      return GestureDetector(
        onTap: () => Get.toNamed(Routes.CREATE_STORY),
        child: Container(
          width: 110,
          margin: const EdgeInsets.only(left: 12.0, right: 6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    image: userImg.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage(userImg),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: userImg.isEmpty
                      ?  Image.network("https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png")
                      : null,
                ),
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: -15,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(Icons.add, color: Colors.white, size: 20),
                      ),
                    ),
                    const Positioned(
                      bottom: 8,
                      child: Text(
                        'Create story',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }




}