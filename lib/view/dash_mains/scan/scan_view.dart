import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/utils/extension.dart';
import 'package:zakat/view/dash_mains/aquisition/aquisition_view.dart';
import 'package:zakat/view/dash_mains/scan/scan_vm.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/sb.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});
  static const String route = '/ScanView';

  @override
  Widget build(BuildContext context) {
    return Consumer<ScanVm>(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded, color: AppColors.btnColor),
          ),
          title: CustomText(
            text: 'Scan to Give',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AquisitionView.route);
              },
              icon: Icon(Icons.notifications_none_rounded, color: Colors.white),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SB.h(40.h),
              

              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: context.height * 0.02),
                child: Image.asset(
                  'scan'.toPngPath,
                  height: 195.h,
                  width: 195.w,
                ),
              ),
              SB.h(20.h),
              Align(
                alignment: Alignment.center,
                child: CustomText(
                  text: 'Shukat Khanam Trust',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SB.h(20.h),
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(12.r),
                  color: Colors.white,
                  dashPattern: [2, 2],
                  strokeWidth: 0.5,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  height: 62,
                  // width: 200,
                  decoration: BoxDecoration(color: Colors.white12),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(
                        width: context.width * 0.5,
                        child: CustomText(
                          text: '3E53XjqK4CxRYUri45445P2Vh…',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.copy_rounded,
                          color: AppColors.btnColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              CustomText(
                text: 'Important',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
              SB.h(10.h),

              CustomText(
                text:
                    'Send only the specified cryptocurrency to the wallet address provided. Sending any other coin or token may result in permanent loss of funds.\nDonations will be credited after 1 network confirmation.\n\nThank you for supporting our cause!.',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              SB.h(50.h),
            ],
          ),
        ),
      ),
    );
  }
}
