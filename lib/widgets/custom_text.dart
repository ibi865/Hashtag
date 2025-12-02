import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final String? fontFamily;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final double? decorationthickness;

  const CustomText(
      {super.key,
      required this.text,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.textAlign,
      this.textDecoration,
      this.decorationColor,
        this.maxLines,
      this.fontFamily,
      this.textOverflow,
      this.decorationthickness});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
       
          fontSize: fontSize ?? 14.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? Colors.white,
          decoration: textDecoration,
          decorationColor: decorationColor,
          decorationThickness: decorationthickness,
          fontFamily: fontFamily ?? 'Rajdhani'),
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      overflow: textOverflow,
    );
  }
}
