import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:provider/provider.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/view/dash_mains/scan/scan_view.dart';
import 'package:zakat/view/dash_mains/scanList/scanList_vm.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/sb.dart';

class ScanlistView extends StatelessWidget {
  const ScanlistView({super.key});
  static const String route = '/ScanlistView';

  @override
  Widget build(BuildContext context) {
    return Consumer<ScanlistVm>(
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
              onPressed: () {},
              icon: Icon(Icons.notifications_none_rounded, color: Colors.white),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SB.h(20.h),
              CustomText(
                text: 'Verified NGO’s',
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              SB.h(20.h),
              Expanded(
                child: ListView.separated(
                  itemCount: 20,

                  itemBuilder: (context, index) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.pushNamed(context, ScanView.route);
                    },
                    child: Row(
                      children: [
                        // SvgPicture.asset('shaukat'.toSvgPath),
                        Image.asset(
                          'shaukat'.toPngPath,
                          width: 40.w,
                          height: 40.w,
                        ),
                        SB.w(10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Shaukat Khanam Trust',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              CustomText(
                                text: '1223412984ndqus..',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        CustomButton(
                          text: 'Donate',
                          width: 103.w,
                          height: 36.h,
                          borderRadius: 8.r,
                          borderColor: AppColors.btnColor,
                          // buttonColor: AppColors.btnColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          onTap: () {
                            Navigator.pushNamed(context, ScanView.route);
                          },
                        ),

                        // SB.w(20.w),
                      ],
                    ),
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
