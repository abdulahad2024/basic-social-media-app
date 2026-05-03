import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:social_media_app/app/modules/home/views/home_view.dart';

import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_typography.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppColors.primary600,
                    shape: BoxShape.circle
                  ),
                  child:  Center(
                    child: Image.asset('assets/logo/logo.png',color: Colors.white,height: 70,width: 70,),
                  ),
                ),
                const SizedBox(height: 30),



                //
                // SizedBox(
                //   height: 25,
                //   width: 25,
                //   child: CircularProgressIndicator(
                //     strokeWidth: 2.5,
                //     color: theme.colorScheme.primary,
                //   ),
                // ),




              ],
            ),
          ),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'from',
                  style: AppTypography.bodyMedium(),
                ),
                const SizedBox(height: 4),
                Text(
                  'ABDUL AHAD',
                  style: AppTypography.titleMedium(color: AppColors.primary600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}