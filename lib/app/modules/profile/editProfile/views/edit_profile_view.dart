import '../controllers/edit_profile_controller.dart';
import 'package:social_media_app/export.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        actions: [
          Obx(() {
            return TextButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () => controller.updateProfile(),
              child: controller.isLoading.value
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () => controller.pickCover(),
                    child: Obx(() {
                      final file = controller.cover.value;
                      final initialUrl = controller.initialCoverUrl;

                      return Container(
                        height: 160,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: file.path.isNotEmpty
                              ? Image.file(file, fit: BoxFit.cover)
                              : (initialUrl != null && initialUrl.isNotEmpty)
                              ? Image.network(initialUrl, fit: BoxFit.cover)
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.gallery_add_copy,
                                      size: 40,
                                      color: theme.colorScheme.primary
                                          .withOpacity(0.6),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Add Cover Photo',
                                      style: AppTypography.labelMedium(),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    }),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () => controller.pickImage(),
                        child: Stack(
                          children: [
                            Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: theme.colorScheme.surface,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Obx(() {
                                final file = controller.image.value;
                                final initialUrl = controller.initialImageUrl;
                                ImageProvider? backgroundImage;
                                if (file.path.isNotEmpty) {
                                  backgroundImage = FileImage(file);
                                } else if (initialUrl != null &&
                                    initialUrl.isNotEmpty) {
                                  backgroundImage = NetworkImage(initialUrl);
                                }

                                return CircleAvatar(
                                  backgroundColor:
                                      theme.colorScheme.surfaceContainerHighest,
                                  backgroundImage: backgroundImage,
                                  child: backgroundImage == null
                                      ? Icon(
                                          Iconsax.camera_copy,
                                          size: 30,
                                          color: theme.colorScheme.primary,
                                        )
                                      : null,
                                );
                              }),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  AppTextFromField(
                    label: 'Full name',
                    hintText: 'Enter your full name',
                    controller: controller.nameController,
                  ),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      // --- Date of Birth Section ---
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date of birth',
                              style: AppTypography.bodyLarge(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () => controller.chooseDate(context),
                              child: Obx(
                                () => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainerHighest
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outlineVariant
                                          .withOpacity(0.9),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.selectedDate.value.isEmpty
                                            ? 'YYYY-MM-DD'
                                            : controller.selectedDate.value,
                                        style: AppTypography.bodyMedium(
                                          color:
                                              controller
                                                  .selectedDate
                                                  .value
                                                  .isEmpty
                                              ? Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant
                                                    .withOpacity(0.6)
                                              : Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                        ),
                                      ),
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        size: 18,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 15),

                      // --- Gender Section ---
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              style: AppTypography.bodyLarge(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant.withOpacity(0.9),
                                ),
                              ),
                              child: Obx(
                                () => DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    menuMaxHeight: 300,
                                    dropdownColor: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    hint: Text(
                                      'Select',
                                      style: AppTypography.bodyMedium(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                    value:
                                        controller.selectedGender.value.isEmpty
                                        ? null
                                        : controller.selectedGender.value,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                    items: controller.genderList.map((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: AppTypography.bodyMedium(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      if (newValue != null) {
                                        controller.selectedGender.value =
                                            newValue;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),


                  AppTextFromField(
                    label: 'Education',
                    hintText: 'School / College / University',
                    controller: controller.educationController,
                  ),
                  const SizedBox(height: 15),

                  AppTextFromField(
                    label: 'Address',
                    hintText: 'City, Country',
                    controller: controller.addressController,
                  ),

                  const SizedBox(height: 15),


                  AppTextFromField(
                    label: 'About',
                    hintText: 'Describe yourself...',
                    maxLines: 3,
                    controller: controller.bioController,
                  ),


                  const SizedBox(height: 40),

                  Obx(
                    () => AppButton(
                      isLoading: controller.isLoading.value,
                      label: "Save",
                      onPressed: () {
                        controller.updateProfile();
                      },
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
