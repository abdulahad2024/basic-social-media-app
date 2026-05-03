import 'package:social_media_app/export.dart';
class PostHeader extends StatelessWidget {
  final dynamic post;

  const PostHeader({super.key, required this.post});

  // 🔥 Safe image builder
  String getImageUrl(String? path) {
    if (path == null || path.isEmpty) {
      return "";
    }

    if (path.startsWith("http")) {
      return path;
    }

    return ApiUrl.imageUrl + path;
  }

  @override
  Widget build(BuildContext context) {
    final user = post['user'] ?? {};

    final int id = user['id'] ?? 0;

    final String imageUrl = getImageUrl(user['profile_image']);

    return ListTile(
      onTap: () {
        Get.toNamed(Routes.USER_PROFILE, arguments: id);
      },

      leading: CircleAvatar(
        backgroundImage: imageUrl.isNotEmpty
            ? NetworkImage(imageUrl)
            : null,
        child: imageUrl.isEmpty
            ?  Image.network("https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png")
            : null,
      ),

      title: Text(
        user['name'] ?? "Unknown",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),

      subtitle: Text(
        post['created_at'].toString().split('T')[0],
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
