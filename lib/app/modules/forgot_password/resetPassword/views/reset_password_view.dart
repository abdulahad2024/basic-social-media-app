import 'package:social_media_app/export.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

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
              'Pick a new Password',
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
              label: 'Password',
              hintText: '********',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              controller: controller.passwordController,
            ),

            const SizedBox(height: 15),

            AppTextFromField(
              label: 'Confirm Password',
              hintText: '********',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              controller: controller.confirmPasswordController,
            ),
            const SizedBox(height: 20),

            Obx(
              () => AppButton(
                label: 'Done',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.resetPassword();
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
