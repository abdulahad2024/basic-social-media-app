import 'package:social_media_app/app/modules/profile/profiles/views/widgets/friends.dart';
import 'package:social_media_app/export.dart';

class ProfilesView extends GetView<ProfilesController> {
  const ProfilesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          controller.getProfile();
          controller.fetchFriends();
        },
        child: SingleChildScrollView(
          child: Obx(() {
            if (controller.isLoading.value) {
              return SizedBox(
                height: 700,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (controller.profile.isEmpty) {
              return SizedBox(
                height: 700,
                child: const Center(child: Text('No profile data available.')),
              );
            }

            final profile = controller.profile;
            final String coverImage =
                (profile['cover_image'] != null &&
                    profile['cover_image'].toString().isNotEmpty)
                ? ApiUrl.imageUrl + profile['cover_image']
                : '';

            final String profileImage =
                (profile['profile_image'] != null &&
                    profile['profile_image'].toString().isNotEmpty)
                ? ApiUrl.imageUrl + profile['profile_image']
                : '';

            print(profileImage);
            print(coverImage);
            final String name = profile['name'] ?? 'No Name';
            final String about = profile['about'] ?? 'No Bio available';
            final String education =
                profile['education'] ?? 'No Education info';
            final String address = profile['address'] ?? 'No Location info';
            final String dateOfBirth =
                profile['dob'] ?? 'No Date of Birth info';
            final String gender = profile['gender'] ?? 'No Gender info';
            final String email = profile['email'] ?? 'No Email info';
            final String phoneNumber =
                profile['phone'] ?? 'No Phone Number info';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(
                  theme: theme,
                  coverImage: coverImage,
                  profileImage: profileImage,
                ),
                ProfileInfo(
                  theme: theme,
                  name: name,
                  friendsCount: controller.friends.length.toString(),
                  bio: about,
                ),
                ProfileActionButton(
                  theme: theme,
                  containerOnTap: () {
                    Get.toNamed(Routes.CREATE_STORY);
                  },
                  iconButtonOnTap: () {
                    Get.toNamed(Routes.EDIT_PROFILE, arguments: profile);
                  },
                  moreOnTap: () {
                    _showMoreOptions(theme);
                  },
                  containerName: 'Add to story',
                  iconButtonName: 'Edit profile',
                  containerIcon: Icons.add_circle,
                  iconButtonIcon: Icons.edit,
                ),
                const SizedBox(height: 10),
                AboutInfo(
                  theme: theme,
                  education: education,
                  address: address,
                  dateOfBirth: dateOfBirth,
                  gender: gender,
                  email: email,
                  phoneNumber: phoneNumber,
                  isUser: true,
                ),

                FriendList(controller: controller),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Posts",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Filters"),
                      ),
                    ],
                  ),
                ),

                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.posts.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("No posts found"),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // Scroll disable rakhte hobe
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      final post = controller.posts[index];
                      return _buildPostItem(post, theme);
                    },
                  );
                }),

                const SizedBox(height: 30),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPostItem(dynamic post, ThemeData theme) {
    // ১. URL হ্যান্ডলিং ফাংশন (এটি ডাবল ইউআরএল হওয়া প্রতিরোধ করবে)
    String getFullUrl(dynamic path) {
      if (path == null || path.toString().isEmpty) return "";
      String stringPath = path.toString();

      // যদি পাথের ভেতর অলরেডি http থাকে, তবে সরাসরি সেটিই রিটার্ন করবে
      if (stringPath.startsWith('http')) {
        return stringPath;
      }

      String baseUrl = ApiUrl.imageUrl;
      if (!baseUrl.endsWith('/')) {
        baseUrl += '/';
      }
      return baseUrl + stringPath;
    }

    final String? postImage =
        (post['image'] != null && post['image'].toString().isNotEmpty)
        ? getFullUrl(post['image'])
        : null;

    final String? postVideo =
        (post['video'] != null && post['video'].toString().isNotEmpty)
        ? getFullUrl(post['video'])
        : null;

    final String userProfile =
        (post['user'] != null && post['user']['profile_image'] != null)
        ? getFullUrl(post['user']['profile_image'])
        : "";

    final String content = post['content'] ?? "";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: userProfile.isNotEmpty
                    ? NetworkImage(userProfile)
                    : null,
                child: userProfile.isEmpty
                    ? const Icon(Icons.person, color: Colors.grey)
                    : null,
              ),
              const SizedBox(width: 10),
              Text(
                post['user']?['name'] ?? 'User',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.more_horiz, color: Colors.grey.shade400),
                onPressed: () {
                  _showPostOptions(Get.context!, post, theme);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Text Content
          if (content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(content, style: const TextStyle(fontSize: 14)),
            ),

          // Post Media (Image/Video)
          if (post['type'] == 'image' && postImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                postImage,
                width: double.infinity,
                height: 250,
                // হাইট বাড়িয়ে দেওয়া হলো দেখার সুবিধার জন্য
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.black12,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  // ইমেজ লোড না হলে এরর মেসেজ কনসোলে প্রিন্ট হবে
                  debugPrint("Image Error: $error | URL: $postImage");
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, color: Colors.grey, size: 40),
                        Text(
                          "Image not found",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          else if (post['type'] == 'video' && postVideo != null)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                // ভিডিওর জন্য কালো ব্যাকগ্রাউন্ড ভালো দেখায়
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 50,
                  color: Colors.white70,
                ),
              ),
            ),

          const SizedBox(height: 12),

          // Like, Comment, Share Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _postStat(
                (post['is_liked'] ?? false) ? Iconsax.like : Iconsax.like,
                (post['likes_count'] ?? 0).toString(),
                (post['is_liked'] ?? false) ? Colors.red : null,
              ),
              _postStat(
                Iconsax.message,
                (post['comments_count'] ?? 0).toString(),
                null,
              ),
              _postStat(
                Iconsax.share,
                (post['shares_count'] ?? 0).toString(),
                null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _postStat(IconData icon, String count, Color? color) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color ?? Colors.grey.shade600),
        const SizedBox(width: 5),
        Text(
          count,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  void _showPostOptions(BuildContext context, dynamic post, ThemeData theme) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),

            // Edit Post
            ListTile(
              leading: const Icon(Iconsax.edit, color: Colors.blue),
              title: const Text("Edit Post"),
              onTap: () {
                Get.back();

                Get.toNamed(Routes.CREATE_POST, arguments: post);

                debugPrint("Navigating to Edit for Post ID: ${post['id']}");
              },
            ),

            // Delete Post
            ListTile(
              leading: const Icon(Iconsax.trash, color: Colors.red),
              title: const Text(
                "Delete Post",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Get.back(); // Close BottomSheet
                _showDeleteConfirmation(context, post, controller);
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    dynamic post,
    ProfilesController controller,
  ) {
    final theme = Theme.of(context);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: theme.cardColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.trash, color: Colors.red, size: 30),
              ),
              const SizedBox(height: 20),

              // টাইটেল
              Text(
                "Delete Post?",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // বর্ণনা
              Text(
                "Are you sure you want to delete this post? This action cannot be undone.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // ডিলিট বাটন
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        controller.deleteMyPost(post['id']);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Delete",
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
      transitionCurve: Curves.easeInOutBack, // সুন্দর এনিমেশন
      barrierDismissible: true,
    );
  }

  void _showMoreOptions(ThemeData theme) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),

            // অপশন লিস্ট
            _buildMenuTile(
              icon: Iconsax.share_copy,
              title: "Share 's Profile",
              onTap: () {
                Get.back();
                // Share logic here
              },
              theme: theme,
            ),
            _buildMenuTile(
              icon: Iconsax.copy_copy,
              title: "Copy link to profile",
              onTap: () {
                Get.back();
                AppUtils.showSuccess("Link copied to clipboard!");
              },
              theme: theme,
            ),
            _buildMenuTile(
              icon: Iconsax.info_circle_copy,
              title: "Support or Report Profile",
              onTap: () {
                Get.back();
              },
              theme: theme,
            ),
            _buildMenuTile(
              icon: Iconsax.user_minus_copy,
              title: "Block User",
              isDestructive: true,
              onTap: () {
                Get.back();
                // Block logic here
              },
              theme: theme,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required ThemeData theme,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : theme.colorScheme.onSurface,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : theme.colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
