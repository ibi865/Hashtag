import 'package:flutter/services.dart';



extension GetSvgPath on String {
  String get toSvgPath => 'assets/svgs/$this.svg';
  String get toPngPath => 'assets/png/$this.png';
  String get toDrawerPath => 'assets/svgs/drawer/$this.svg';
    String get toBottomNavPath => 'assets/svgs/bottomNav/$this.svg';
  String get toDashboardPath => 'assets/svgs/dashboard/$this.svg';
}

String cap(String? text) {
  if (text == null || text.isEmpty) return '--';
  return text[0].toUpperCase() + text.substring(1);
}