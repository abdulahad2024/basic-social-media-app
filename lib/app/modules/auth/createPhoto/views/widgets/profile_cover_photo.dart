import 'package:social_media_app/export.dart';
class ProfileCoverPhoto extends StatelessWidget {
  const ProfileCoverPhoto({
    super.key,
    required this.controller,
    required this.theme,
  });

  final CreatePhotoController controller;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        clipBehavior: Clip.none,
        children: [


          GestureDetector(
            onTap: () => controller.pickCover(),
            child: Obx(() {
              bool hasImage = controller.cover.value.path.isNotEmpty;
              return Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(alpha:
                  0.5,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: hasImage
                      ? Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        controller.cover.value,
                        fit: BoxFit.cover,
                      ),
                    ],
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 40,
                        color: theme.colorScheme.primary
                            .withValues(alpha: 0.6),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add Cover Photo',
                        style: AppTypography.labelMedium(
                          color:
                          theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),

          Positioned(
            bottom: 0,
            left: 20,
            child: GestureDetector(
              onTap: () {
                controller.pickImage();
              },
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.surface,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Obx(() {
                  if (controller.image.value.path.isNotEmpty) {
                    return ClipOval(
                      child: Image.file(
                        controller.image.value,
                        fit: BoxFit.cover,
                      ),
                    );
                  }

                  return Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 30,
                      color: theme.colorScheme.primary,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
