import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../controllers/home_controller.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 85,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? theme.colorScheme.surface.withOpacity(0.8)
                  : theme.colorScheme.surface.withOpacity(0.85),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: theme.dividerColor.withOpacity(0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(
                    context: context,
                    icon: Iconsax.home_2,
                    label: 'Home',
                    index: 0,
                    controller: controller,
                  ),
                  _navItem(
                    context: context,
                    icon: Iconsax.people,
                    label: 'Friends',
                    index: 1,
                    controller: controller,
                  ),
                  const SizedBox(width: 48), // Floating Action Button এর জন্য গ্যাপ
                  _navItem(
                    context: context,
                    icon: Iconsax.video_circle,
                    label: 'Watch',
                    index: 2,
                    controller: controller,
                  ),
                  _navItem(
                    context: context,
                    icon: Iconsax.user,
                    label: 'Profile',
                    index: 3,
                    controller: controller,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required HomeController controller,
  }) {
    final theme = Theme.of(context);
    bool isSelected = controller.selectedIndex.value == index;

    // সিলেকশন কালার হিসেবে থিমের প্রাইমারি কালার ব্যবহার করা হয়েছে
    Color activeColor = theme.colorScheme.primary;
    Color inactiveColor = theme.unselectedWidgetColor.withOpacity(0.5);

    return InkWell(
      onTap: () => controller.changeIndex(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected
                  ? activeColor.withOpacity(0.12)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 24,
            ),
          ),
          // Active indicator dot
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 4,
            width: isSelected ? 4 : 0,
            decoration: BoxDecoration(
              color: activeColor,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    );
  }
}