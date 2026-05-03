import 'package:social_media_app/export.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              'OTP sent',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Enter the OTP sent to you',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOtpBox(
                  context: context,
                  controller: controller.c1,
                  first: true,
                  last: false,
                ),
                CustomOtpBox(
                  context: context,
                  controller: controller.c2,
                  first: false,
                  last: false,
                ),
                CustomOtpBox(
                  context: context,
                  controller: controller.c3,
                  first: false,
                  last: false,
                ),
                CustomOtpBox(
                  context: context,
                  controller: controller.c4,
                  first: false,
                  last: true,
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Text(
                  "Didn't receive any code? ",
                  style: theme.textTheme.bodyMedium,
                ),
                Obx(
                  () => GestureDetector(
                    onTap: controller.isResendAvailable.value
                        ? () {
                            controller.startTimer();
                            controller.resendOtp();
                          }
                        : null,
                    child: Text(
                      controller.isResendAvailable.value
                          ? "Resend Code"
                          : "Resend in ${controller.timerText}",
                      style: TextStyle(
                        color: controller.isResendAvailable.value
                            ? theme.colorScheme.primary
                            : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Obx(
              () => AppButton(
                label: 'Next',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.verifyOtp();
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
