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

  // Hashtag colors for variety
  static const List<Color> hashtagColors = [
    Color(0xff15a5be), // Cyan
    Color(0xffFF6B6B), // Coral Red
    Color(0xff4ECDC4), // Turquoise
    Color(0xffFFE66D), // Yellow
    Color(0xffA8E6CF), // Mint Green
    Color(0xffFF8B94), // Pink
    Color(0xff95E1D3), // Light Teal
    Color(0xffF38181), // Salmon
    Color(0xffAA96DA), // Lavender
    Color(0xffFCBAD3), // Light Pink
  ];

  static Color getHashtagColor(String hashtag) {
    // Use hash code to consistently assign colors to same hashtags
    final hash = hashtag.hashCode;
    return hashtagColors[hash.abs() % hashtagColors.length];
  }

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
