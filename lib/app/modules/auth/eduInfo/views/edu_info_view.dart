import 'package:social_media_app/export.dart';

class EduInfoView extends GetView<EduInfoController> {
  const EduInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.xl2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Education Information',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Text(
              'Please fill the following',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
            ),
            const SizedBox(height: 30),

            AppTextFromField(
              controller: controller.eduController,
              label: 'Education',
              hintText: 'School / College / University',
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 15),

            AppTextFromField(
              controller: controller.addressController,
              label: 'Address',
              hintText: 'City, Country',
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 15),

            AppTextFromField(
              controller: controller.aboutController,
              label: 'About Me',
              hintText: 'About Me',
              maxLines: 3,
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 20),

            Obx(
              () => AppButton(
                label: 'Next',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.eduInfo();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AuthFooter(),
    );
  }
}
