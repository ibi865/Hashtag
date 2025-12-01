import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zakat/utils/extension.dart';

import '../utils/app_constants.dart';
import '../utils/color_resources.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final String? fontFamily;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? buttonColor;
  final Color? borderColor;
  final String? iconPath;
  final Function()? onTap;
  final double? borderRadius;
  final bool? isLoading;
  final Widget? leadingIcon;
  final Widget? trailing;


  const CustomButton(
      {super.key,
      required this.text,
      this.fontWeight,
      this.fontSize,
      this.textColor,
      this.height,
      this.width,
      this.iconPath,
      this.buttonColor,
      this.onTap,
      this.borderRadius,
      this.fontFamily,
      this.isLoading,
      this.borderColor,
      this.trailing,
      this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading != null && isLoading! == true ? () {} : onTap,
      child: Container(
        height: height ?? 44.h,
        width: width ?? context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 46.r),
          color: buttonColor ?? Colors.transparent,
          border: buttonColor != null
              ? null
              : Border.all(color: borderColor ?? Colors.red),
        ),
        child: Center(
          child: isLoading != null && isLoading!
              ? CircularProgressIndicator(
                  color: textColor ?? Colors.white,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (iconPath != null) SvgPicture.asset(iconPath!),
                    if(leadingIcon != null) leadingIcon!,
                    SizedBox(
                      width: iconPath != null ? 10.w : 0,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          color: textColor ?? Colors.white,
                          fontSize: fontSize ?? 16.sp,
                          fontWeight: fontWeight ?? FontWeight.w600,
                          fontFamily: fontFamily ?? 'Rajdhani'),
                    ),
                    SizedBox(
                      width: trailing != null ? 10.w : 0,
                    ),
                    if(trailing != null) trailing!,
                  ],
                ),
        ),
      ),
    );
  }
}
