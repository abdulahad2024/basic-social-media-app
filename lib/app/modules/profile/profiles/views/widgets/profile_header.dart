import 'package:social_media_app/export.dart';

class ProfileHeader extends StatelessWidget {
  final String coverImage;
  final String profileImage;

  const ProfileHeader({
    super.key,
    required this.theme,
    required this.coverImage,
    required this.profileImage,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 150,
          width: double.infinity,
          color: theme.colorScheme.surfaceContainerHighest,
          child: Image.network(
            coverImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.image, color: Colors.red)),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Positioned(
          bottom: -50,
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 56,
              backgroundImage: NetworkImage(profileImage),
            ),
          ),
        ),
      ],
    );
  }
}
