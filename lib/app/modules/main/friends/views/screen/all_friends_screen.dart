import 'package:social_media_app/export.dart';

class AllFriendsScreen extends StatelessWidget {
  const AllFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FriendsController>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => controller.allUser(),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.users.isEmpty) {
            return const Center(child: Text("No Users Found"));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.users.length,
            separatorBuilder: (_, _) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              final user = controller.users[index];
              final int id = user.id ?? 0;

              final image =
                  (user.profileImage != null && user.profileImage!.isNotEmpty)
                  ? "${ApiUrl.imageUrl}${user.profileImage}"
                  : "https://ui-avatars.com/api/?name=${user.name}";

              final request = controller.pendingRequests.firstWhereOrNull(
                (e) => e.senderId == id || e.sender?.id == id,
              );

              final requestId = request?.id;

              return Obx(() {
                final isLoading = controller.loadingIds.contains(id);

                return CustomFriend(
                  id: id,
                  name: user.name ?? "User",
                  image: image,
                  status: "Suggested for you",
                  isSent: user.isSent,
                  isFriend: user.isFriend,
                  isReceived: user.isReceived,

                  isLoading: isLoading,

                  onPrimaryTap: () {
                    if (user.isReceived && requestId != null) {
                      controller.acceptRequest(requestId, id);
                    } else if (!user.isSent && !user.isFriend) {
                      controller.sendFriendRequest(id);
                    }
                  },

                  onSecondaryTap: () {
                    controller.users.removeAt(index);
                  },

                  profileTap: () =>
                      Get.toNamed(Routes.USER_PROFILE, arguments: id),
                );
              });
            },
          );
        }),
      ),
    );
  }
}
