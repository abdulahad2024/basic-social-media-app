import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/app/modules/main/main/views/shimmer/post_shimmer.dart';
import 'package:social_media_app/app/modules/main/main/views/widgets/post_footer.dart';
import 'package:social_media_app/app/modules/main/main/views/widgets/post_header.dart';
import 'package:social_media_app/app/modules/main/main/views/widgets/video_player_widget.dart';
import '../controllers/main_controller.dart';
import 'package:social_media_app/export.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FaceVibe',
          style: AppTypography.titleLarge(color: AppColors.primary600),
        ),
        actions: [
          BuildAction(onPressed: () async {

          }, icon: Icons.search),
          BuildAction(onPressed: () {
            Get.toNamed(Routes.MENUS);
          }, icon: Iconsax.menu),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchFeeds();
          await controller.getStories();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: PostInputArea()),
            SliverToBoxAdapter(child: StorySection()),
            Obx(() {
              if (controller.isLoading.value) {
                return const SliverToBoxAdapter(
                  child: PostShimmer(),
                );
              }

              if (controller.postList.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(child: Text("No posts found")),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final post = controller.postList[index];
                    final String postType = post['type'] ?? 'text';

                    // পাস করা হচ্ছে post এবং index
                    switch (postType) {
                      case 'image':
                        return ImagePostCard(post: post, index: index);
                      case 'video':
                        return VideoPostCard(post: post, index: index);
                      default:
                        return TextPostCard(post: post, index: index);
                    }
                  },
                  childCount: controller.postList.length,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class TextPostCard extends StatelessWidget {
  final dynamic post;
  final int index;
  const TextPostCard({super.key, required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostHeader(post: post),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            post['content'] ?? "",
            style: AppTypography.titleMedium(),
          ),
        ),
        const SizedBox(height: 5),
        PostFooter(post: post, index: index),
        const SizedBox(height: 5),
      ],
    );
  }
}


class ImagePostCard extends StatelessWidget {
  final dynamic post;
  final int index;

  const ImagePostCard({
    super.key,
    required this.post,
    required this.index,
  });

  String getImageUrl(String? path) {
    if (path == null || path.isEmpty) return "";

    if (path.startsWith("http")) {
      return path;
    }

    return ApiUrl.imageUrl + path;
  }

  @override
  Widget build(BuildContext context) {
    final String content = post['content'] ?? '';
    final String image = post['image'] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostHeader(post: post),

        /// CONTENT
        if (content.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              content,
              style: AppTypography.titleMedium(),
            ),
          ),

        const SizedBox(height: 4),

        /// IMAGE
        if (image.isNotEmpty)
          Image.network(
            getImageUrl(image),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250,

            /// SHIMMER LOADING
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;

              return Shimmer.fromColors(
                baseColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
                highlightColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade700
                    : Colors.grey.shade100,
                child: Container(
                  width: double.infinity,
                  height: 250,
                  color: Theme.of(context).colorScheme.surface,
                ),
              );
            },

            /// ERROR
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 250,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Icon(
                    Icons.broken_image,
                    size: 50,
                  ),
                ),
              );
            },
          ),

        const SizedBox(height: 5),

        PostFooter(post: post, index: index),

        const SizedBox(height: 5),
      ],
    );
  }
}

class VideoPostCard extends StatelessWidget {
  final dynamic post;
  final int index;
  const VideoPostCard({super.key, required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostHeader(post: post),
        if (post['content'] != null && post['content'] != "")
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(post['content'], style: AppTypography.titleMedium()),
          ),
        const SizedBox(height: 4),
        VideoPlayerWidget(
          videoUrl: "${ApiUrl.imageUrl}${post['video']}",
        ),
        const SizedBox(height: 5),
        PostFooter(post: post, index: index),
        const SizedBox(height: 5),
      ],
    );
  }
}



