import 'package:social_media_app/export.dart';

class PersonalInfoView extends GetView<PersonalInfoController> {
  const PersonalInfoView({super.key});

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
              'Personal Information',
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
              label: 'Full name',
              hintText: 'Full Name',
              keyboardType: TextInputType.text,

              controller: controller.nameController,
            ),

            const SizedBox(height: 15),

            AppTextFromField(
              label: 'Email Address',
              hintText: 'example@gmail.com',
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailController,
            ),

            const SizedBox(height: 15),

            DobGender(controller: controller),

            const SizedBox(height: 20),

            Obx(
              () => AppButton(
                label: 'Next',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.personalInfo();
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
