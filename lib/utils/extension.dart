import 'package:flutter/material.dart';

extension NavigatorExtention on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  
  void pop([dynamic value]) => Navigator.of(this).pop(value);
}
