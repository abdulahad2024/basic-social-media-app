import '../controllers/create_post_controller.dart';
import 'package:social_media_app/export.dart';

class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfilesController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Obx(() => Text(
          controller.isEditMode.value ? 'Edit Post' : 'Create Post',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        )),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.close, color: colorScheme.onSurface),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        String? profilePath = profileController.profile['profile_image'];
        final String userImg = (profilePath != null && profilePath.isNotEmpty)
            ? ApiUrl.imageUrl + profilePath
            : "";
        final name = profileController.profile['name'] ?? "User";

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // --- User Profile Info ---
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(userImg),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            _buildPrivacyBadge(theme, colorScheme),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // --- Content Input Field ---
                    AppTextFromField(
                      controller: controller.contentController,
                      hintText: "What's on your mind?",
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                    ),

                    const SizedBox(height: 15),

                    // --- Media Preview Section (Network or File) ---
                    _buildMediaPreview(colorScheme),

                    const SizedBox(height: 15),

                    _buildMediaPickerButtons(theme, colorScheme),

                    const SizedBox(height: 25),

                    Obx(
                          () => AppButton(
                        label: controller.isEditMode.value ? "Update Now" : "Post Now",
                        isLoading: controller.isLoading.value,
                        onPressed: () => controller.submitPost(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // --- Privacy Badge Widget ---
  Widget _buildPrivacyBadge(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          const Icon(Icons.public, size: 12),
          const SizedBox(width: 4),
          Text(
            'Public',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(Icons.arrow_drop_down, size: 16, color: colorScheme.outline),
        ],
      ),
    );
  }

  // --- Media Preview Logic (File + Network) ---
  Widget _buildMediaPreview(ColorScheme colorScheme) {
    return Obx(() {
      bool hasLocalFile = controller.selectedFile.value != null;
      bool hasOldImage = controller.oldImageUrl.value != null;
      bool hasOldVideo = controller.oldVideoUrl.value != null;

      if (!hasLocalFile && !hasOldImage && !hasOldVideo) {
        return const SizedBox.shrink();
      }

      return Stack(
        children: [
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 250),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _getPreviewWidget(),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () => controller.removeFile(),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: colorScheme.error.withOpacity(0.8),
                child: const Icon(Icons.close, size: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _getPreviewWidget() {
    if (controller.selectedFile.value != null) {
      if (controller.isVideo.value) {
        return const Center(child: Icon(Icons.play_circle_fill, size: 60, color: Colors.blue));
      }
      return Image.file(controller.selectedFile.value!, fit: BoxFit.cover);
    }
    if (controller.oldImageUrl.value != null) {
      return Image.network(ApiUrl.imageUrl + controller.oldImageUrl.value!, fit: BoxFit.cover);
    }
    if (controller.oldVideoUrl.value != null) {
      return const Center(child: Icon(Icons.play_circle_fill, size: 60, color: Colors.redAccent));
    }
    return const SizedBox.shrink();
  }

  Widget _buildMediaPickerButtons(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          _pickerItem(
            icon: Icons.photo_library,
            color: Colors.green,
            label: 'Photo',
            theme: theme,
            onTap: () => controller.pickMedia(fromVideo: false),
          ),
          Container(width: 1, height: 20, color: colorScheme.outlineVariant),
          _pickerItem(
            icon: Icons.video_call,
            color: Colors.redAccent,
            label: 'Video',
            theme: theme,
            onTap: () => controller.pickMedia(fromVideo: true),
          ),
        ],
      ),
    );
  }

  Widget _pickerItem({
    required IconData icon,
    required Color color,
    required String label,
    required ThemeData theme,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}