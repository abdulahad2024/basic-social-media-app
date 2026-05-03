import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/app/modules/home/views/widgets/bottom.dart';
import 'package:social_media_app/app/routes/app_pages.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_typography.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: AppColors.primary600,
        shape: const CircleBorder(),
        onPressed: () => Get.toNamed(Routes.CREATE_POST),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),

      bottomNavigationBar: const MainBottomNavigationBar(),

      body: Obx(() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: controller.pages[controller.selectedIndex.value],
      )),
    );
  }
}

