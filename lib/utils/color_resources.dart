import 'package:flutter/material.dart';

class AppColors {
  static var primary = const Color(0xff031733);

  AppColors._();

  static const Color btnColor = Color(0xff15a5be);
  static const Color bgColor = Color(0xff0d121e);
  static const Color grey = Color(0xff475467);
  static const Color tileColor = Color(0xff353535);
  static const Color textBlue = Color(0xff007AFF);
  static const Color textGreen = Color(0xff34C759);



  static getActivityStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.amber;
      case 'succeeded':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return textBlue;
    }
  }
}
