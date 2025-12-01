import 'package:flutter/material.dart';
import 'package:zakat/utils/color_resources.dart';

class BackgroundWidget extends StatelessWidget {
  Widget childWidget;
  double width;
  double height;
  BackgroundWidget({super.key,required this.childWidget,required this.width,required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.bgColor
      ),
      child: childWidget,
    );
  }
}
