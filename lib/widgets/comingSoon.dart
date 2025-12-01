import 'package:flutter/material.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/widgets/custom_text.dart';

class Comingsoon extends StatelessWidget {
  const Comingsoon({super.key, this.showbackButton = true});
  static const String route = '/Comingsoon';
  final bool showbackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        automaticallyImplyLeading: true,
        leading: showbackButton ? IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.btnColor,
          ),
        ) : null,
      ) ,
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: CustomText(
          text: 'Coming Soon',
          fontSize: 32.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.btnColor,
        ),
      ),
    );
  }
}
