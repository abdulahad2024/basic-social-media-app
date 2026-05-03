import 'package:social_media_app/export.dart';
class FriendList extends StatelessWidget {
  const FriendList({
    super.key,
    required this.controller,
  });

  final ProfilesController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final friendList = controller.friends;

      if (friendList.isEmpty) {
        return const Center(child: Text('No friends data available.'));
      }

      return FriendHorizontalList(
        itemCount: friendList.length,
        onTap: (index) {


        },
        nameBuilder: (index) => friendList[index].name ?? "Friend Name",
        imageBuilder: (index) {
          final String? imgPath = friendList[index].profileImage;
          return (imgPath != null && imgPath.isNotEmpty)
              ? ApiUrl.imageUrl + imgPath
              : 'https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png';
        },
      );

    });
  }
}
