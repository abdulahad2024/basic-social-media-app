import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkUtils {

  static Future<bool> hasInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
  }

  static void showNoInternetSnackbar() {
    Get.snackbar(
      "No Internet",
      "আপনার ইন্টারনেট কানেকশন চেক করুন!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: const Icon(Icons.wifi_off, color: Colors.white),
      margin: const EdgeInsets.all(15),
      duration: const Duration(seconds: 3),
    );
  }
}