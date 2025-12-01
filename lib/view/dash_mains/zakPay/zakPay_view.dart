import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/helper/time_formatter.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/view/dash_mains/payment/payment_view.dart';
import 'package:zakat/view/dash_mains/zakPay/zakPay_vm.dart';
import 'package:zakat/widgets/comingSoon.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/sb.dart';

class ZakpayView extends StatelessWidget {
  const ZakpayView({super.key});
  static const String route = '/ZakpayView';

  @override
  Widget build(BuildContext context) {
    return Consumer<ZakpayVm>(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: AppColors.btnColor),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SvgPicture.asset(
                'onboard'.toSvgPath,
                width: 64.w,
                height: 55.h,
              ),
              CustomText(
                text: 'Zakat Pay',
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
            child: Column(
              children: [
                SB.h(20.h),
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
                            text: vm.zktcBalance != null
                                ? "${vm.zktcBalance} ZKTC"
                                : "0.0 ZKTC",
                            fontWeight: FontWeight.w600,
                            fontSize: 43.24.sp,
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      text: 'Add Funds',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      buttonColor: AppColors.btnColor,
                      borderRadius: 8.r,
                      width: 103.w,
                      height: 36.h,
                      onTap: () {
                        Navigator.pushNamed(context, PaymentView.route).then((value){
                          vm.getWalletBalance();
                        });
                      },
                    ),
                  ],
                ),
                SB.h(10.h),

                CustomButton(
                  text: 'Make Withdraw',
                  height: 50.h,
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                  borderRadius: 8.r,
                  onTap: () {Navigator.pushNamed(context, Comingsoon.route);},
                ),
                SB.h(20.h),
                CustomButton(
                  text: 'Unlink The Account',
                  height: 50.h,
                  borderColor: AppColors.btnColor,
                  textColor: AppColors.btnColor,
                  borderRadius: 8.r,
                  onTap: () {Navigator.pushNamed(context, Comingsoon.route);},
                ),
                SB.h(20.h),
                Row(
                  children: [
                    CustomText(
                      text: 'Recent Activity',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    Spacer(),
                    CustomText(
                      text: 'See All',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.btnColor,
                    ),
                  ],
                ),
                vm.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.btnColor,
                        ),
                      )
                    : vm.activityList.isEmpty
                    ? Center(
                        child: CustomText(
                          text: 'No Activity',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          controller: vm.scrollController,
                          itemCount: vm.activityList.length,
                          itemBuilder: (context, index) {
                            final data = vm.activityList[index];
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {

                                vm.launchBlockchainUrls(
                                  'ethereum',
                                  data.contractTransactionHash ?? '',
                                );
                              },
                              child: Row(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: data.walletAddress ?? '',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          textOverflow: TextOverflow.ellipsis,
                                        ),
                                        CustomText(
                                          text: data.createdAt != null
                                              ? formatTimeWithTimezone(
                                                  data.createdAt!,
                                                )
                                              : '--',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                          textOverflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SB.w(20.w),
                                  Spacer(),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,

                                    children: [
                                      CustomText(
                                        text: '\$ ${data.amountUsd}',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                      CustomText(
                                        text: data.status ?? '',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.getActivityStatusColor(
                                          data.status ?? '',
                                        ),
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
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
                      vm.isScrollLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.btnColor,
                              ),
                            )
                          : SizedBox.shrink(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
