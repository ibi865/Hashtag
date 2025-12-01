import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:provider/provider.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/view/dash_mains/holdList/holdList_vm.dart';
import 'package:zakat/view/dash_mains/scanList/scanList_view.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/sb.dart';

class HoldlistView extends StatelessWidget {
  const HoldlistView({super.key});
  static const String route = '/HoldlistView';

  @override
  Widget build(BuildContext context) {
    return Consumer<HoldlistVm>(
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
            text: 'Hold to Give',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_none_rounded, color: Colors.white),
            ),
          ],
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SB.h(20.h),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  text: 'Mint NFT',
                  width: 103.w,
                  height: 36.h,
                  borderRadius: 8.r,
                  buttonColor: AppColors.btnColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  onTap: () {},
                ),
              ),
              SB.h(20.h),
              Expanded(
                child: ListView.separated(
                  itemCount: 20,

                  itemBuilder: (context, index) => Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: AppColors.btnColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'wallet'.toSvgPath,
                            width: 18.w,
                            height: 18.w,
                          ),
                        ),
                      ),
                      SB.w(10.w),
                      SizedBox(
                        width: 120.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: '12412984ndqussdfoisdfsdfsdfs',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            CustomText(
                              text: '12:30 +5 GMT',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // SB.w(20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            CustomText(
                              text: '2.5%',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            CustomText(
                              text: 'Zakat %',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textBlue,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          CustomText(
                            text: '-ZKTC50.000',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          CustomText(
                            text: '30 days',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textBlue,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => Column(
                    children: [
                      SB.h(5.h),
                      Divider(
                        thickness: 0.3.h,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
