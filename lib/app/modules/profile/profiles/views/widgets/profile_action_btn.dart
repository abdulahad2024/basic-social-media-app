import 'package:social_media_app/export.dart';

class ProfileActionButton extends StatelessWidget {
  final Function()? containerOnTap;
  final Function()? iconButtonOnTap;
  final Function()? moreOnTap;

  final String containerName;
  final String iconButtonName;

  const ProfileActionButton({
    super.key,
    required this.theme,
    this.containerOnTap,
    this.iconButtonOnTap,
    this.moreOnTap,
    required this.containerName,
    required this.iconButtonName,
    required this.containerIcon,
    required this.iconButtonIcon,
     this.isFriend = false,
  });

  final ThemeData theme;
  final IconData containerIcon;
  final IconData iconButtonIcon;
  final bool isFriend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: containerOnTap,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(containerIcon, color: Colors.white, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      containerName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.withValues(alpha: 0.15),
                  foregroundColor: theme.colorScheme.onSurface,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Icon(iconButtonIcon, size: 18),
                label: Text(iconButtonName),
                onPressed: iconButtonOnTap,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.more_horiz, size: 20),
              onPressed: moreOnTap,
            ),
          ),
        ],
      ),
    );
  }
}
