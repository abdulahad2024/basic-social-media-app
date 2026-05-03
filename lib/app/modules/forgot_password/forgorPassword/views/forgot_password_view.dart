import 'package:social_media_app/export.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

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
              'Forgot Password',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Text(
              'Let’s help recover your account',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
            ),
            const SizedBox(height: 30),

            AppTextFromField(
              label: 'Email Address',
              hintText: 'example@gmail.com',
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailController,
            ),

            const SizedBox(height: 20),

            Obx(
              () => AppButton(
                label: 'Send Otp',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.forgotPassword();
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
