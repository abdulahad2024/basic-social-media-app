import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app/routes/app_pages.dart';

import '../../../data/services/api/auth_services.dart';
import '../../../data/services/seassion/auth_seassion.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    _startNavigation();
  }

  Future<void> _startNavigation() async {
    final AuthSession authSession = AuthSession();
    final AuthServices authServices = AuthServices();

    await Future.delayed(const Duration(seconds: 3));

    final token = await authSession.getToken();

    if (token == null) {
      Get.offAllNamed(Routes.LOGIN);
      return;
    }

    Get.offAllNamed(Routes.HOME);

    // try {
    //   final response = await authServices.getProfile();
    //
    //   final user = response?['user'];
    //
    //   if (user == null) {
    //     Get.offAllNamed(Routes.LOGIN);
    //     return;
    //   }
    //
    //   if (user['phone'] == null) {
    //     Get.offAllNamed(Routes.OTP, arguments: user['phone']);
    //     return;
    //   }
    //
    //
    //   if (user['name'] == null || user['gender'] == null || user['dob'] == null || user['email'] == null) {
    //     Get.offAllNamed(Routes.PERSONAL_INFO);
    //     return;
    //   }
    //
    //   if (user['education'] == null || user['address'] == null || user['about'] == null) {
    //     Get.offAllNamed(Routes.EDU_INFO);
    //     return;
    //   }
    //
    //   if (user['password'] == null || user['password_confirmation'] == null) {
    //     Get.offAllNamed(Routes.CREATE_PASSWORD);
    //     return;
    //   }
    //
    //   if (user['image'] == null || user['is_profile_complete'] == false || user['cover'] == null) {
    //     Get.offAllNamed(Routes.CREATE_PHOTO);
    //     return;
    //   }

    //
    // } catch (e) {
    //   debugPrint("Splash Navigation Error: $e");
    //   Get.offAllNamed(Routes.LOGIN);
    // }
  }
  }
