import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:social_media_app/app/modules/main/menus/views/widgets/build_item_menu.dart';
import 'package:social_media_app/app/modules/main/menus/views/widgets/profile_card.dart';
import 'package:social_media_app/app/modules/profile/profiles/controllers/profiles_controller.dart';
import 'package:social_media_app/app/utils/theme/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/menus_controller.dart';

class MenusView extends GetView<MenusController> {
  const MenusView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final profileController = Get.put(ProfilesController());

    final profile = profileController.profile;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await profileController.getProfile();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              BuildProfileCard(theme: theme),

              const SizedBox(height: 20),

              BuildItemMenuSection(
                title: "Account Settings",
                items: [
                  _menuItem(theme, Iconsax.user, "Personal Information", () {}),
                  _menuItem(theme, Iconsax.setting_2, "Account Settings", () {
                    Get.toNamed(Routes.EDIT_PROFILE, arguments: profile);

                  }),
                  _menuItem(theme, Iconsax.notification, "Notifications", () {}),
                ],
              ),



              BuildItemMenuSection(
                title: "Support & Others",
                items: [
                  _menuItem(theme, Iconsax.info_circle, "Help & Support", () {
                    // Help Center ba FAQ page-e niye jabe
                  }),
                  _menuItem(
                    theme,
                    Iconsax.message_question,
                    "Report a Problem",
                    () {
                      // Bug report ba feedback deoyar jonno
                    },
                  ),
                  _menuItem(theme, Iconsax.shield_tick, "Privacy Policy", () {
                    // Privacy policy link
                  }),
                  _menuItem(theme, Iconsax.document_text, "Terms of Service", () {
                    // Terms and conditions
                  }),
                  _menuItem(theme, Iconsax.star, "Rate Our App", () {
                    // Play Store ba App Store link-e niye jabe
                  }),
                  _menuItem(theme, Iconsax.share, "Invite Friends", () {
                    // App link share korar options
                  }),
                  _menuItem(
                    theme,
                    Iconsax.logout,
                    "Logout",
                    () => _showLogoutDialog(context),
                    isExit: true,
                  ),
                ],
              ),



              const SizedBox(height: 30),
              Text(
                "Version 1.0.0",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }


  Widget _menuItem(
    ThemeData theme,
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isExit = false,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isExit
              ? Colors.red.withValues(alpha: 0.1)
              : AppColors.primary500.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 22,
          color: isExit ? Colors.red : AppColors.primary500,
        ),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: isExit ? Colors.red : theme.colorScheme.onSurface,
        ),
      ),
      trailing: Icon(
        Iconsax.arrow_right_3,
        size: 16,
        color: Colors.grey.shade400,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to logout?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        // Handle Logout
      },
    );
  }
}
