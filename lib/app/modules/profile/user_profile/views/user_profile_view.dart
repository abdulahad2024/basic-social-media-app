import 'package:social_media_app/export.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final friendController = Get.put(FriendsController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(
          () => Text(controller.userProfile.value.user?.name ?? 'Profile'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.loadAllData();
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final profileModel = controller.userProfile.value;
          final user = profileModel.user;

          if (user == null) {
            return const Center(child: Text('No profile data available.'));
          }

          final int userId = user.id ?? 0;

          final dynamic activeUser = friendController.users.firstWhere(
            (u) => u.id == userId,
            orElse: () => User(),
          );

          final String coverImage =
              (user.coverImage != null && user.coverImage!.isNotEmpty)
              ? ApiUrl.imageUrl + user.coverImage!
              : 'https://via.placeholder.com/400x150';

          final String profileImage =
              (user.profileImage != null && user.profileImage!.isNotEmpty)
              ? ApiUrl.imageUrl + user.profileImage!
              : 'https://via.placeholder.com/150';

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(
                  theme: theme,
                  coverImage: coverImage,
                  profileImage: profileImage,
                ),
                ProfileInfo(
                  theme: theme,
                  name: user.name ?? 'No Name',
                  friendsCount: controller.friends.length.toString(),
                  bio: user.about ?? 'No Bio available',
                ),
                ProfileActionButton(
                  theme: theme,
                  containerOnTap: () {
                    if (activeUser.isFriend != true &&
                        activeUser.isSent != true) {
                      friendController.sendFriendRequest(userId);
                    }
                  },
                  iconButtonOnTap: () {

                  },
                  moreOnTap: () => _showMoreOptions(context, activeUser),
                  containerName: friendController.loadingIds.contains(userId)
                      ? 'Processing...'
                      : (activeUser.isFriend ?? false)
                      ? 'Friends'
                      : (activeUser.isSent ?? false)
                      ? 'Requested'
                      : (activeUser.isReceived ?? false)
                      ? 'Accept'
                      : 'Add friend',

                  containerIcon: (activeUser.isFriend ?? false)
                      ? Icons.person_3
                      : (activeUser.isSent ?? false)
                      ? Icons.pending_actions
                      : (activeUser.isReceived ?? false)
                      ? Icons.person_add_alt_1
                      : Icons.person_add,

                  iconButtonName: 'Message',
                  iconButtonIcon: Iconsax.sms,
                  isFriend: activeUser.isFriend ?? false,
                ),
                const SizedBox(height: 10),
                AboutInfo(
                  theme: theme,
                  education: user.education ?? 'No Education info',
                  address: user.address ?? 'No Location info',
                  dateOfBirth: user.dob ?? 'No Date info',
                  gender: user.gender ?? 'No Gender info',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: Text(
                    "Friends",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                UserFriend(controller: controller),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: Text(
                    "Posts",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                Obx(() {
                  final posts = controller.posts;

                  if (posts.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(child: Text("No posts available")),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            leading: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: NetworkImage(profileImage),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            title: Text(
                              user.name ?? "User",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  post.type ?? "Post",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.public,
                                  size: 12,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),

                          if (post.content != null && post.content!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 0,
                              ),
                              child: Text(
                                post.content!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.4,
                                  color: Colors.black87,
                                ),
                              ),
                            ),

                          if (post.video != null && post.video!.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => VideoPlayerPage(
                                    videoUrl: ApiUrl.imageUrl + post.video!,
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                width: double.infinity,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const Icon(
                                      Icons.play_circle_fill,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                    const Positioned(
                                      bottom: 10,
                                      child: Text(
                                        "Click to Play",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else if (post.image != null && post.image!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  ApiUrl.imageUrl + post.image!,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Container(
                                          height: 250,
                                          width: double.infinity,
                                          color: Colors.grey[100],
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        );
                                      },
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        height: 200,
                                        width: double.infinity,
                                        color: Colors.grey[100],
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                          size: 40,
                                        ),
                                      ),
                                ),
                              ),
                            ),

                          const SizedBox(height: 12),
                        ],
                      );
                    },
                  );
                }),

                const SizedBox(height: 20),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _showMoreOptions(BuildContext context, dynamic user) {
    if (user == null || user.id == null) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Wrap(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: SizedBox(
                width: 40,
                child: Divider(thickness: 4),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_remove, color: Colors.red),
            title: Text(
              'Unfriend ${user.name ?? "User"}',
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
            ),
            onTap: () {

              Get.dialog(
                barrierDismissible: false,
                Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person_remove_rounded, color: Colors.red, size: 40),
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          "Unfriend User?",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),

                        // মেসেজ
                        Text(
                          "Are you sure you want to remove ${user.name} from your friends list?",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                        ),
                        const SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => Get.back(),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.unFriends(user.id.toString());
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  "Unfriend",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }}
