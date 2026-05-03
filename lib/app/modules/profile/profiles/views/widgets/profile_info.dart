import 'package:social_media_app/export.dart';
class ProfileInfo extends StatelessWidget {
  final String name;
  final String friendsCount;
  final String bio;
  final ThemeData theme;

  const ProfileInfo({
    super.key,
    required this.theme,
    required this.name,
    required this.friendsCount,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),

          Text(
            name.isNotEmpty ? name : 'No Name',
            textAlign: TextAlign.center,
            style: AppTypography.titleLarge(),
          ),

          const SizedBox(height: 6),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$friendsCount ',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                TextSpan(
                  text: 'friends',
                  style: AppTypography.titleSmall(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Text(
            bio.isNotEmpty ? bio : 'No bio available',
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
