import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/sb.dart';


class CustomConfirmationDialogue extends StatelessWidget {
  CustomConfirmationDialogue(
      {super.key,
      required this.onOk,
      required this.oncancel,
      required this.content,
      required this.title,
      this.canceltxt,
      this.oktxt});
  final VoidCallback oncancel;
  final VoidCallback onOk;
  final String content;
  final String title;
  final String? canceltxt;
  final String? oktxt;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: CustomText(
        text: title,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      content: CustomText(
        text: content,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomButton(
                //width: 100.w,
                borderColor: Colors.black,
                height: 40.h,
                text: canceltxt?? 'No',
                onTap: oncancel,
                //buttonColor: Colors.white,
                textColor: Colors.black,
              ),
            ),
            SB.w(20.w),
            Expanded(
              child: CustomButton(
                //width: 100,
                height: 40,
                text: oktxt??'Yes',
                onTap: onOk, // This removes all the previous routes.

                buttonColor: AppColors.btnColor,
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ],
    );
  }
}
