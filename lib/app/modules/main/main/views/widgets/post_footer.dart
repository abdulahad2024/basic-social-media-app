import 'package:social_media_app/app/modules/main/main/controllers/main_controller.dart';
import 'package:social_media_app/export.dart';

class PostFooter extends GetView<MainController> {
  final dynamic post;
  final int index;

  const PostFooter({
    super.key,
    required this.post,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Index safety check
      if (index >= controller.postList.length) return const SizedBox();

      // IMPORTANT: Direct index theke data nawa jate rebuild trigger hoy
      final postData = controller.postList[index];

      // Robust Liked Check: Bool, Int ba String ja-ই ashuk handle korbe
      final bool isLiked = postData['is_liked'] == true ||
          postData['is_liked'].toString() == '1' ||
          postData['is_liked'].toString() == 'true';

      final int likesCount = int.tryParse(postData['likes_count'].toString()) ?? 0;
      final int commentsCount = (postData['comments'] as List?)?.length ??
          int.tryParse(postData['comments_count'].toString()) ?? 0;
      final int sharesCount = int.tryParse(postData['shares_count'].toString()) ?? 0;

      return Column(
        children: [
          // Counts Row
          if (likesCount > 0 || commentsCount > 0 || sharesCount > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  if (likesCount > 0) ...[
                    // Icon color fixed based on isLiked status
                    Icon(
                        isLiked ? Iconsax.like : Iconsax.like,
                        size: 16,
                        color: isLiked ? Colors.blue : Colors.grey
                    ),
                    const SizedBox(width: 5),
                    Text("$likesCount",
                        style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                  const Spacer(),
                  if (commentsCount > 0)
                    Text("$commentsCount Comments  ",
                        style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  if (sharesCount > 0)
                    Text("$sharesCount Shares",
                        style: const TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),

          const Divider(height: 1, thickness: 0.5),

          // Buttons Row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                _buildAction(
                  // FIX: isLiked true hole Iconsax.like5 (Solid) ar false hole Iconsax.like_1 (Outline)
                  icon: isLiked ? Iconsax.like : Iconsax.like_1,
                  label: "Like",
                  iconColor: isLiked ? Colors.blue : Colors.grey[600],
                  textColor: isLiked ? Colors.blue : Colors.grey[600],
                  onTap: () => controller.toggleLike(postData['id'], index),
                ),
                _buildAction(
                  icon: Iconsax.message_text,
                  label: "Comment",
                  iconColor: Colors.grey[600],
                  onTap: () => showCommentSheet(context, postData, index),
                ),
                _buildAction(
                  icon: Iconsax.send_2,
                  label: "Share",
                  iconColor: Colors.grey[600],
                  onTap: () => controller.sharePost(postData),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: textColor ?? Colors.grey[600],
                  fontSize: 13,
                  fontWeight: textColor != null ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCommentSheet(BuildContext context, dynamic post, int index) {
    final theme = Theme.of(context);

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Text(
              "Comments",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Divider(height: 1, color: theme.dividerColor),
            Expanded(
              child: Obx(() {
                if (index >= controller.postList.length) return const SizedBox();
                final currentPost = controller.postList[index];
                final List comments = currentPost['comments'] ?? [];

                if (comments.isEmpty) {
                  return const Center(child: Text("No comments yet", style: TextStyle(color: Colors.grey)));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: comments.length,
                  itemBuilder: (context, i) {
                    final comment = comments[i];
                    final userData = comment['user'];
                    final String name = userData?['name'] ?? "User";

                    String imageUrl = "";
                    String? path = userData?['profile_image'];
                    if (path != null && path.isNotEmpty) {
                      imageUrl = path.startsWith("http") ? path : (ApiUrl.imageUrl + path);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(
                              imageUrl.isNotEmpty ? imageUrl : "https://ui-avatars.com/api/?name=$name",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                      const SizedBox(height: 2),
                                      Text(comment['comment'] ?? ""),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, top: 4),
                                  child: Text(
                                    comment['created_at'].toString().split('T')[0],
                                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: theme.dividerColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.commentController,
                      decoration: InputDecoration(
                        hintText: "Write a comment...",
                        filled: true,
                        fillColor: theme.colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppColors.primary600,
                    child: IconButton(
                      onPressed: () => controller.addComment(post['id'], index),
                      icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}