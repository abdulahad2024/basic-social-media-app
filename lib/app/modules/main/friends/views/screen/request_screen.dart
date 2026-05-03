import 'package:social_media_app/export.dart';

class RequestScreen extends GetView<FriendsController> {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FriendsController>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => controller.allPendingRequest(),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.pendingRequests.isEmpty) {
            return const Center(child: Text("No Friend Requests"));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.pendingRequests.length,
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              final request = controller.pendingRequests[index];
              final sender = request.sender;

              final name = sender?.name ?? "User";
              final id = sender?.id ?? 0;

              final image =
                  (sender?.profileImage != null &&
                      sender!.profileImage!.isNotEmpty)
                  ? "${ApiUrl.imageUrl}${sender.profileImage}"
                  : "https://ui-avatars.com/api/?name=$name";

              return Obx(() {
                final isLoading = controller.loadingIds.contains(id);

                return PendingFriendCard(
                  name: name,
                  image: image,
                  isLoading: isLoading,

                  onAccept: () {
                    controller.acceptRequest(request.id ?? 0, id);
                  },

                  onReject: () {
                    controller.rejectRequest(request.id ?? 0, id);
                  },
                );
              });
            },
          );
        }),
      ),
    );
  }
}
