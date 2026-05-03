import 'package:social_media_app/export.dart';

class CreatePasswordView extends GetView<CreatePasswordController> {
  const CreatePasswordView({super.key});

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
              'Create Password',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Text(
              'Help secure your account',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
            ),
            const SizedBox(height: 30),

            AppTextFromField(
              controller: controller.passwordController,
              label: 'Password',
              hintText: '********',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),

            const SizedBox(height: 15),

            AppTextFromField(
              controller: controller.confirmPasswordController,
              label: 'Confirm Password',
              hintText: '********',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),

            const SizedBox(height: 20),

            Obx(
              () => AppButton(
                label: 'Done',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.createPassword();
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
