import 'package:social_media_app/app/modules/auth/login/views/widgets/login_footer.dart';
import 'package:social_media_app/export.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.xl2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log In',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Text(
              'Enter your credentials',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
            ),
            const SizedBox(height: 30),

            AppTextFromField(
              label: 'Email or Phone',
              hintText: 'Email or Phone',
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailPhoneController,
            ),

            const SizedBox(height: 15),

            AppTextFromField(
              label: 'Password',
              hintText: '*********',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              controller: controller.passwordController,
            ),

            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.FORGOR_PASSWORD);
                },
                child: Text('Forgot Password?'),
              ),
            ),

            const SizedBox(height: 15),

            Obx(
              () => AppButton(
                label: 'Log In',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.login();
                },
              ),
            ),

            SizedBox(height: 15),

            LogInFooter(),
          ],
        ),
      ),
    );
  }
}
