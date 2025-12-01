import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/view/bottomNav/bottom_nav_vm.dart';
import 'package:zakat/view/dash_mains/payment/payment_view.dart';
import 'package:zakat/view/tabs/dashboard/dashboard_vm.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/custom_textfield.dart';

class DashboardView extends StatelessWidget {
  static const String route = '/dashboardView';
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DashboardVm, BottomNavVm>(
      builder: (context, vm, bVm,_) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.bgColor,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: SizedBox(
                height: 30.h,
                child: CustomTextField(
                  borderRadius: 8.r,
                  showBorders: true,
                  cursorColor: Colors.white,
                  color: Colors.white,
                  borderColor: AppColors.grey,
                  hintText: 'ZKTC',
                  hintColor: AppColors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  icon: Icon(Icons.search, color: Colors.white),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.notifications_none_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.qr_code_scanner, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0.w,
                vertical: 20.h,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: "1 ZKTC~\$67399.41 SOL",
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                            CustomText(
                              text: vm.zktcBalance != null ?"${vm.zktcBalance} ZKTC" :"0.0 ZKTC",
                              fontWeight: FontWeight.w600,
                              fontSize: 43.24.sp,
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        text: 
                        // vm.walletAddress != null || bVm.walletAddress != null ?
                         'Add Funds' ,
                        //  : 'Connect Wallet',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        buttonColor: AppColors.btnColor,
                        borderRadius: 8.r,
                        width:vm.walletAddress != null || bVm.walletAddress != null ? 103.w : 130.w,
                        height: 36.h,
                        onTap: () {
                          Navigator.pushNamed(context, PaymentView.route).then((value){
                              vm.getWalletBalance();
                            });
                          // if(vm.walletAddress == null && bVm.walletAddress == null){
                          //   vm.connectWallet(context);
                          // } else{
                            
                          // }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 185.h,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: vm.dashboardItems.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemBuilder: (context, index) {
                        final item = vm.dashboardItems[index];
                        return DashboardItems(
                          svgPicture: item['svgPath']!,
                          text: item['text']!,
                          onTap: () => vm.handleDashboardItemTap(context, index, item['text']!),
                        );
                      },
                    ),
                  ),
                  CustomButton(
                    text: 'Discover More'.toUpperCase(),
                    borderColor: Colors.white10,
                    fontWeight: FontWeight.w500,
                    height: 24.h,
                    width: 103.w,
                    fontSize: 12.sp,
                    borderRadius: 8.r,
                  ),
                  SizedBox(height: 10.h),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     CustomText(text: 'Progress & Reward', fontSize: 20.sp),
                  //     CustomText(
                  //       text: 'View All',
                  //       fontSize: 12.sp,
                  //       fontWeight: FontWeight.w700,
                  //       color: AppColors.btnColor,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10.h),
                  // Expanded(
                  //   child: SingleChildScrollView(
                  //     child: Column(
                  //       children: [
                  //         RewardContainer(
                  //           medal: 'Bronze',
                  //           completePercentage: 100,
                  //           days: 30,
                  //           status: 'Your NFT has been transferred',
                  //           showCup: true,
                  //         ),
                  //         SizedBox(height: 10.h),
                  //         RewardContainer(
                  //           medal: 'Silver',
                  //           completePercentage: 75,
                  //           days: 185,
                  //           status: 'Error',
                  //           showCup: false,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // )
                  Expanded(child: Center(
                    child: CustomText(
                      text: 'Coming Soon',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.btnColor,
                    ),
                  ),)
                 
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  
}

class DashboardItems extends StatelessWidget {
  final String svgPicture;
  final String text;
  final Function()? onTap;
  const DashboardItems({
    super.key,
    required this.svgPicture,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: 52.h,
              width: 52.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.white10),
              ),
              child: svgPicture.isEmpty
                  ? Icon(Icons.qr_code_scanner, color: Colors.white)
                  : Center(
                      child: SvgPicture.asset(
                        svgPicture,
                        height: 22.h,
                        width: 22.w,
                      ),
                    ),
            ),
            SizedBox(height: 5.h),
            CustomText(
              text: text,
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class RewardContainer extends StatelessWidget {
  final String medal;
  final double completePercentage;
  final int days;
  final String status;
  final bool showCup;
  const RewardContainer({
    super.key,
    required this.medal,
    required this.completePercentage,
    required this.days,
    required this.status,
    required this.showCup,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 184.h,
      width: 380.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      medal.toLowerCase() == 'bronze'
                          ? 'bronze'.toDashboardPath
                          : 'silver'.toDashboardPath,
                    ),
                    SizedBox(width: 5.w),
                    CustomText(
                      text: medal,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward, color: Colors.black),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomText(
                          text: "$completePercentage% Complete",
                          color: Color(0xff34c759),
                          fontWeight: FontWeight.w400,
                        ),
                        CustomText(
                          text: "$days Days",
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.8.r),
                            color: AppColors.btnColor.withOpacity(0.1),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 8.h,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified, color: Color(0xff34c759)),
                              SizedBox(width: 5.w),
                              Flexible(
                                fit: FlexFit.loose,
                                child: CustomText(
                                  text: status,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  maxLines: 1,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showCup)
                    SvgPicture.asset('cup'.toDashboardPath)
                  else
                    Spacer(),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            LinearProgressIndicator(
              color: Color(0xff34c759),
              value: completePercentage / 100,
              minHeight: 6.h,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ],
        ),
      ),
    );
  }
}
