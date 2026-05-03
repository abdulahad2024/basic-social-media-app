import 'package:social_media_app/export.dart';
class AboutInfo extends StatelessWidget {
  final String education;
  final String address;
  final String dateOfBirth;
  final String gender;
  final String? email;
  final String? phoneNumber;
  final ThemeData theme;
  final bool isUser;

  const AboutInfo({
    super.key,
    required this.theme,
    required this.education,
    required this.address,
    required this.dateOfBirth,
    required this.gender,
     this.email,
     this.phoneNumber,  this.isUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoItem(
            icon: Iconsax.teacher_copy,
            title: 'Studied at ',
            subtitle: education,
            theme: theme,
          ),

          InfoItem(
            icon: Iconsax.house_2_copy,
            title: 'Lives in ',
            subtitle: address,
            theme: theme,
          ),

          // Date of Birth
          InfoItem(
            icon: Iconsax.cake_copy,
            title: 'Born on ',
            subtitle: dateOfBirth,
            theme: theme,
          ),

          InfoItem(
            icon: Iconsax.user_copy,
            title: 'Gender: ',
            subtitle: gender.capitalizeFirst ?? gender,
            theme: theme,
          ),

          if (isUser) ...[
            InfoItem(
            icon: Iconsax.call_copy,
            title: 'Phone: ',
            subtitle: phoneNumber ?? 'No phone number',
            theme: theme,
          ),

          InfoItem(
            icon: Iconsax.sms_copy,
            title: 'Email: ',
            subtitle: email ?? 'No email',
            theme: theme,
          ),
          ],
        ],
      ),
    );
  }
}
class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.theme,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.onSurfaceVariant, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  TextSpan(
                    text: subtitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
