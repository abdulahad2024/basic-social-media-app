import 'package:social_media_app/export.dart';

class LogInFooter extends StatelessWidget {
  const LogInFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'I don\'t have an account?',
            style: AppTypography.bodyMedium().copyWith(),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => Get.offAllNamed(Routes.PHONE),
            child: Text(
              'Sign Up',
              style: AppTypography.bodyMedium(
                color: AppColors.primary600,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
