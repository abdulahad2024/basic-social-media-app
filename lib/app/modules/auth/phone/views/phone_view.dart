import 'package:social_media_app/export.dart';

class PhoneView extends GetView<PhoneController> {
  const PhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.offAllNamed(Routes.LOGIN),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.xl2),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Phone',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              AppTextFromField(
                controller: controller.phoneController,
                label: 'Enter your phone number',
                hintText: '01xxxxxxxxx',
                keyboardType: TextInputType.phone,
                isPhoneField: true,
                validator: controller.validatePhone,
                maxLength: 11,
              ),
              const SizedBox(height: 15),

              Obx(
                () => AppButton(
                  label: 'Next',
                  isLoading: controller.isLoading.value,
                  onPressed: () => controller.otpSend(),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: AuthFooter(),
    );
  }
}
