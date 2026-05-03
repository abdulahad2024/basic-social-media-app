import 'package:social_media_app/export.dart';

class CreatePhotoView extends GetView<CreatePhotoController> {
  const CreatePhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () => Get.back(),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.xl2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Photo',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Please fill the profile and cover photo',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 30),

            ProfileCoverPhoto(controller: controller, theme: theme),

            const SizedBox(height: 50),
            Obx(
              () => AppButton(
                label: 'Next',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.createPhoto();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AuthFooter(),
    );
  }
}

