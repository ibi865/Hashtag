import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:provider/provider.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/view/dash_mains/convert/convert_vm.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/custom_textfield.dart';
import 'package:zakat/widgets/sb.dart';

class ConvertView extends StatelessWidget {
  const ConvertView({super.key});
  static const String route = '/ConvertView';

  @override
  Widget build(BuildContext context) {
    return Consumer<ConvertVm>(
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
            text: 'Zak Pay',
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
        bottomNavigationBar: BottomAppBar(
          color: AppColors.bgColor,
          child: CustomButton(
            onTap: () async {
              await vm.convert(context);
            },
            isLoading: vm.isLoading,
            text: 'Convert',
            fontWeight: FontWeight.w400,
            fontSize: 18.sp,
            height: 44.h,
            buttonColor: AppColors.btnColor,
            borderRadius: 8.r,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
          child: Column(
            children: [
              SB.h(40.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: 'From',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        Spacer(),
                        CustomText(
                          text: 'Available: 0(USDT)',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        SB.w(5.w),
                        SvgPicture.asset(
                          'expand_more'.toSvgPath,
                          height: 2.49.h,
                          width: 4.8.w,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'usdt'.toSvgPath,
                          height: 16.h,
                          width: 16.w,
                        ),
                        SB.w(10.w),
                        CustomText(
                          text: 'USDT',
                          fontSize: 19.5.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SB.w(10.w),
                        SvgPicture.asset(
                          'expand_more'.toSvgPath,
                          height: 5.h,
                          width: 9.6.w,
                        ),
                        Expanded(
                          child: CustomTextField(
                            // isReadOnly: true,
                            controller: vm.fromController,
                            keyboardType: TextInputType.number,
                            showBorders: false,
                            backgroundColor: Colors.transparent,
                            cursorColor: Colors.white,
                            hintText: "--",
                            
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            hintFontWeight: FontWeight.w600,
                            color: Colors.white,
                            hintColor: Colors.grey,
                            textAlign: TextAlign.end,
                            onTap: () {
                              // vm.activeController = vm.fromController;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SB.h(20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: 'From',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        Spacer(),
                        CustomText(
                          text: 'Available: 0(USDT)',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        SB.w(5.w),
                        SvgPicture.asset(
                          'expand_more'.toSvgPath,
                          height: 2.49.h,
                          width: 4.8.w,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'zktc'.toSvgPath,
                          height: 16.h,
                          width: 16.w,
                        ),
                        SB.w(10.w),
                        CustomText(
                          text: 'ZKTC',
                          fontSize: 19.5.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SB.w(10.w),
                        SvgPicture.asset(
                          'expand_more'.toSvgPath,
                          height: 5.h,
                          width: 9.6.w,
                        ),
                        Expanded(
                          child: CustomTextField(
                            // isReadOnly: true,
                            controller: vm.toController,
                            keyboardType: TextInputType.number,
                            showBorders: false,
                            backgroundColor: Colors.transparent,
                            cursorColor: Colors.white,
                            hintText: "--",
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            hintFontWeight: FontWeight.w600,
                            color: Colors.white,
                            hintColor: Colors.grey,
                            textAlign: TextAlign.end,
                            onTap: () {
                              // vm.activeController = vm.toController;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Spacer(),
              // buildNumpad(vm),
              // SB.h(30.h)
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildButton(
  //   ConvertVm vm,
  //   String value, {
  //   double size = 70,
  //   VoidCallback? onTap,
  // }) {
  //   return InkWell(
  //     borderRadius: BorderRadius.circular(8.r),
  //     onTap: onTap ?? () => vm.onKeyTap(value),
  //     child: Container(
  //       margin: EdgeInsets.symmetric(horizontal: 4.w),
  //       height: 46.h,
  //       // width: size,
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: Colors.white24,
  //         borderRadius: BorderRadius.circular(8.r),
  //       ),
  //       child: Text(
  //         value,
  //         style:  TextStyle(
  //           fontSize: 25.sp,
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //           fontFamily: 'Rajdhani'
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildNumpad(ConvertVm vm) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Expanded(child: buildButton(vm, "1")),
  //           Expanded(child: buildButton(vm, "2")),
  //           Expanded(child: buildButton(vm, "3")),
  //         ],
  //       ),
  //       const SizedBox(height: 12),
  //       Row(
  //         children: [
  //           Expanded(child: buildButton(vm, "4")),
  //           Expanded(child: buildButton(vm, "5")),
  //           Expanded(child: buildButton(vm, "6")),
  //         ],
  //       ),
  //       const SizedBox(height: 12),
  //       Row(
  //         children: [
  //           Expanded(child: buildButton(vm, "7")),
  //           Expanded(child: buildButton(vm, "8")),
  //           Expanded(child: buildButton(vm, "9")),
  //         ],
  //       ),
  //       const SizedBox(height: 12),
  //       Row(
  //         children: [
  //           Expanded(
  //             child: InkWell(
  //               borderRadius: BorderRadius.circular(8.r),
  //               onTap: ()=>vm.onKeyTap('.'),
  //               child: Container(
  //                 margin: EdgeInsets.symmetric(horizontal: 4.w),
  //                 height: 46.h,

  //                 // width: size,
  //                 child: Center(
  //                   child: Text(
  //                     '.',
  //                     style:  TextStyle(
  //                       fontSize: 25.sp,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Expanded(child: buildButton(vm, "0")),
  //           Expanded(
  //             child: InkWell(
  //               borderRadius: BorderRadius.circular(8.r),
  //               onTap: vm.onBackspace,
  //               child: Container(
  //                 height: 46.h,
  //                 alignment: Alignment.center,

  //                 child: SvgPicture.asset('Remove'.toSvgPath),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
