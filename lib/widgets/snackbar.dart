import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zakat/utils/color_resources.dart';

class SnackBars {


  static void showErroredGetSnackBar(BuildContext context, String message) {
    if (Get.isSnackbarOpen == true) return;
    Get.rawSnackbar(
      icon: const Icon(Icons.error, color: Colors.red),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }
  static void showComingSoon(BuildContext context) {
    if (Get.isSnackbarOpen == true) return;
    Get.rawSnackbar(
      icon: const Icon(Icons.info, color: AppColors.btnColor),
      messageText: Text(
        'Feature Coming Soon',
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }
}
