import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/utils/app_constants.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/view/dash_mains/payment/payment_vm.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_confirmation_dialogue.dart';
import 'package:zakat/widgets/custom_dialog.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/custom_textfield.dart';
import 'package:zakat/widgets/sb.dart';
import 'package:zakat/widgets/snackbar.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});
  static const String route = '/PaymentView';

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentVm>(
      builder: (context, vm, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: AppColors.btnColor),
        ),
        backgroundColor: AppColors.bgColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(
            left: context.width * 0.04,
            right: context.width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SB.h(100.h),
              CustomText(
                text: 'Reserve Tokens Here',
                fontWeight: FontWeight.w700,
                fontSize: 32.sp,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      vm.showDisclaimer = false;
                      vm.pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                      vm.currentTabIndex = 0;
                    },
                    child: CustomButton(
                      text: 'Crypto',
                      buttonColor: vm.currentTabIndex == 0
                          ? AppColors.btnColor
                          : Colors.transparent,
                      textColor: vm.currentTabIndex == 0
                          ? Colors.white
                          : Colors.grey,
                      borderRadius: 8.r,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      height: 40.h,
                      width: 120.w,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      vm.showDisclaimer = false;
                      vm.pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                      vm.currentTabIndex = 1;
                      vm.defaultTokenRate = vm.defaultTokenRateForUSDT();
                      log(
                        'default token rate for usdt: ${vm.defaultTokenRate}',
                      );
                    },
                    child: CustomButton(
                      text: 'Fiat',
                      buttonColor: vm.currentTabIndex == 1
                          ? AppColors.btnColor
                          : Colors.transparent,
                      textColor: vm.currentTabIndex == 1
                          ? Colors.white
                          : Colors.grey,
                      borderRadius: 8.r,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      height: 40.h,
                      width: 120.w,
                    ),
                  ),
                ],
              ),
              SB.h(20.h),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: context.width * 0.02,
                    right: context.width * 0.02,
                    // bottom: MediaQuery.of(context).viewInsets.bottom
                  ),
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: vm.pageController,
                    scrollBehavior: CustomScrollBehavior(),
                    onPageChanged: (index) {
                      vm.currentTabIndex = index;
                    },
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 1,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.white12,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: context.width * 0.02,
                                right: context.width * 0.02,
                                bottom: MediaQuery.of(
                                  context,
                                ).viewInsets.bottom,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SB.h(20.h),
                                  CustomText(
                                    text: 'From Wallet Address',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.sp,
                                    color: Colors.white,
                                  ),

                                  SB.h(10.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                      horizontal: 12.w,
                                    ),
                                    height: 50.h,
                                    width: context.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Colors.white10,
                                    ),
                                    child: CustomText(
                                      text: vm.walletAddress,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SB.h(10.h),
                                  CustomButton(
                                    text:
                                        (AppConstants.walletAddress.isNotEmpty)
                                        ? 'Wallet Connected'
                                        : 'Connect Wallet',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    buttonColor: AppColors.btnColor,
                                    textColor: Colors.white,
                                    borderRadius: 12.r,
                                    isLoading: vm.isConnecting,
                                    onTap: () {
                                      if (AppConstants.walletAddress.isEmpty) {
                                        vm.connectWallet(context);
                                      } else {
                                        // Show dropdown menu for connected wallet
                                        _showWalletMenu(context, vm);
                                      }
                                    },
                                  ),
                                  SB.h(10.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              text: 'Token',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                            ),
                                            SB.h(10.h),
                                            CustomTextField(
                                              controller: vm.tokenCtrl,
                                              keyboardType:
                                                  TextInputType.number,
                                              showBorders: false,
                                              backgroundColor: Colors.white10,
                                              cursorColor: Colors.white,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              hintText: "",
                                              isReadOnly: true,
                                              prefixPadding: 0,
                                              icon: vm.tokenCtrl.text == 'USDT'
                                                  ? SvgPicture.asset(
                                                      AppConstants.getTokenImage(
                                                        vm.tokenCtrl.text,
                                                      ),
                                                      width: 20.w,
                                                      height: 20.h,
                                                    )
                                                  : Image.asset(
                                                      AppConstants.getTokenImage(
                                                        vm.tokenCtrl.text,
                                                      ),
                                                      width: 20.w,
                                                      height: 20.h,
                                                    ),
                                              onTap: () {
                                                vm.showCoinPairBottomSheet(
                                                  context,
                                                );
                                              },
                                              suffixWidget: SvgPicture.asset(
                                                'expand_more'.toSvgPath,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SB.w(10.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,

                                          children: [
                                            CustomText(
                                              text: 'Amount',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                            ),
                                            SB.h(10.h),
                                            Form(
                                              key: vm.cryptoKey,
                                              child: CustomTextField(
                                                validatorFunction: (value) {
                                                  if (value == null ||
                                                      value.trim().isEmpty) {
                                                    return "Amount is required";
                                                  }
                                                  final parsed =
                                                      double.tryParse(value);
                                                  if (parsed == null) {
                                                    return "Enter a valid number";
                                                  }
                                                  if (parsed <= 0) {
                                                    return "Amount must be greater than zero";
                                                  }
                                                  return null;
                                                },
                                                controller: vm.cryptoAmountCtrl,
                                                keyboardType:
                                                    TextInputType.number,
                                                showBorders: false,
                                                backgroundColor: Colors.white10,
                                                cursorColor: Colors.white,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                hintText: "",
                                                onChanged: (value) {
                                                  final amount =
                                                      double.tryParse(value) ??
                                                      0;
                                                  if (amount > 1000) {
                                                    // allow editing donation
                                                  } else {
                                                    vm.cryptoDonationCtrl.text =
                                                        "2.5";
                                                    vm.cryptoDonationPercentage =
                                                        2.5;
                                                  }

                                                  vm.update();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  if ((double.tryParse(
                                            vm.cryptoAmountCtrl.text,
                                          ) ??
                                          0) >
                                      1000) ...[
                                    SB.h(15.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 18.h,
                                        horizontal: 8.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        border: Border.all(
                                          width: 0.1,
                                          color: Colors.white60,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SB.h(15.h),
                                          CustomText(
                                            text:
                                                "Donation Percentage: ${vm.cryptoDonationPercentage.toStringAsFixed(1)}%",
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                          SB.h(15.h),
                                          SliderTheme(
                                            data: SliderTheme.of(context).copyWith(
                                              trackHeight:
                                                  8.0, // thickness of slider track
                                              thumbShape:
                                                  const RoundSliderThumbShape(
                                                    enabledThumbRadius: 8,
                                                  ), // bigger thumb
                                              overlayShape:
                                                  const RoundSliderOverlayShape(
                                                    overlayRadius: 18,
                                                  ), // ripple around thumb
                                              activeTrackColor: Colors.blue,
                                              inactiveTrackColor:
                                                  Colors.grey[300],
                                              thumbColor: Colors.blue,
                                              valueIndicatorColor:
                                                  Colors.blueAccent,
                                            ),
                                            child: Slider(
                                              padding: EdgeInsets.all(0),
                                              value:
                                                  vm.cryptoDonationPercentage,
                                              thumbColor: AppColors.textBlue,
                                              activeColor: AppColors.btnColor,
                                              inactiveColor: Colors.white12,

                                              min: 1.0,
                                              max: 10.0,
                                              divisions: 90, // gives step = 0.1
                                              label: vm.cryptoDonationPercentage
                                                  .toStringAsFixed(1),
                                              onChanged: (value) =>
                                                  vm.cryptoSetDonation(value),
                                            ),
                                          ),
                                          SB.h(15.h),
                                          // Scale under the slider (only show major ticks for clarity)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                              10,
                                              (index) => CustomText(
                                                text:
                                                    "${(index + 1).toDouble().toStringAsFixed(1)}",
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  SB.h(20.h),
                                  Container(
                                    width: context.width,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 18.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Colors.white10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: 'You Receive',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color: Colors.grey,
                                        ),
                                        // SB.h(5.h),
                                        CustomText(
                                          text:
                                              (vm.zktcPrice == null ||
                                                  vm.defaultTokenRate == null)
                                              ? '--'
                                              : vm
                                                    .cryptoAmountCtrl
                                                    .text
                                                    .isNotEmpty
                                              ? '${(((vm.getCryptoAmount(vm.tokenCtrl.text) * vm.defaultTokenRate!) / vm.zktcPrice!) - ((vm.getCryptoAmount(vm.tokenCtrl.text) * vm.defaultTokenRate!) / vm.zktcPrice! * vm.cryptoDonationPercentage / 100)).toStringAsFixed(1)} ZKTC'
                                              : '0.0 ZKTC',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24.sp,
                                          color: Colors.white,
                                          textOverflow: TextOverflow.ellipsis,
                                        ),
                                        SB.h(10.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              text: 'Donated Amount: ',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp,
                                              color: Colors.grey,
                                            ),
                                            SB.w(5.h),
                                            CustomText(
                                              text: vm.zktcPrice == null
                                                  ? '--'
                                                  : vm
                                                        .cryptoAmountCtrl
                                                        .text
                                                        .isNotEmpty
                                                  ? '${((vm.getCryptoAmount(vm.tokenCtrl.text) / vm.zktcPrice!) * vm.cryptoDonationPercentage / 100).toStringAsFixed(1)} ZKTC'
                                                  : '0.0 ZKTC',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              color: Colors.grey,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  SB.h(10.h),
                                  CustomButton(
                                    text: 'Convert',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    buttonColor:
                                        (AppConstants.walletAddress.isNotEmpty)
                                        ? AppColors.btnColor
                                        : Colors.grey,
                                    textColor: Colors.white,
                                    borderRadius: 12.r,
                                    isLoading: vm.isLoading,
                                    onTap: (AppConstants.walletAddress.isEmpty)
                                        ? null
                                        : () {
                                            showDialog(
                                              context: context,
                                              builder: (builder) => CustomConfirmationDialogue(
                                                onOk: () async {
                                                  vm.showDisclaimer = true;
                                                  Navigator.pop(context);
                                                  log('converting');

                                                  if (vm.cryptoKey.currentState!
                                                      .validate()) {
                                                    try {
                                                      vm.isLoading = true;

                                                      // Check if MetaMask is installed
                                                      final isMetaMaskInstalled =
                                                          await vm.walletService
                                                              .isMetaMaskInstalled();
                                                      if (!isMetaMaskInstalled) {
                                                        vm.isLoading = false;
                                                        customErrorDialog(
                                                          context,
                                                          "MetaMask is not installed. Please install MetaMask from the App Store or Google Play Store.",
                                                        );
                                                        return;
                                                      }
                                                      double amount =
                                                          double.tryParse(
                                                            vm
                                                                .cryptoAmountCtrl
                                                                .text,
                                                          ) ??
                                                          0.0;
                                                      if (!await vm.getRemainingDCOSupply(
                                                        amount:
                                                            ((vm.getCryptoAmount(
                                                                      vm
                                                                          .tokenCtrl
                                                                          .text,
                                                                    ) *
                                                                    vm.defaultTokenRate!) /
                                                                vm.zktcPrice!) -
                                                            ((vm.getCryptoAmount(
                                                                      vm
                                                                          .tokenCtrl
                                                                          .text,
                                                                    ) *
                                                                    vm.defaultTokenRate!) /
                                                                vm.zktcPrice! *
                                                                vm.cryptoDonationPercentage /
                                                                100),
                                                      )) {
                                                        return;
                                                      }

                                                      String
                                                      recipientAddress = await vm
                                                          .getRecipientAddress();
                                                      log(
                                                        "Recipient address: $recipientAddress",
                                                      );

                                                      final result = await vm
                                                          .walletService
                                                          .signAndTransferUsdt(
                                                            recipientAddress:
                                                                recipientAddress
                                                                    .trim(),
                                                            usdtAmount: vm
                                                                .cryptoAmountCtrl
                                                                .text
                                                                .trim(),
                                                            donationPercentage:
                                                                vm.cryptoDonationPercentage,
                                                          );

                                                      vm.isLoading = false;
                                                      log(
                                                        "result: ${jsonEncode(result)}",
                                                      );
                                                    } catch (e) {
                                                      vm.isLoading = false;
                                                      log("Convert error: $e");

                                                      String errorMessage = e
                                                          .toString();
                                                      if (errorMessage.contains(
                                                        "MetaMask is not installed",
                                                      )) {
                                                        customErrorDialog(
                                                          context,
                                                          "MetaMask is not installed. Please install MetaMask from the App Store or Google Play Store.",
                                                        );
                                                      } else if (errorMessage
                                                          .contains(
                                                            "timeout",
                                                          )) {
                                                        customErrorDialog(
                                                          context,
                                                          "MetaMask took too long to respond. Please make sure MetaMask is open and try again.",
                                                        );
                                                      } else if (errorMessage
                                                          .contains(
                                                            "not responding",
                                                          )) {
                                                        customErrorDialog(
                                                          context,
                                                          "MetaMask is not responding. Please restart MetaMask and try again.",
                                                        );
                                                      } else {
                                                        customErrorDialog(
                                                          context,
                                                          "Transaction failed: ${errorMessage.replaceAll('Exception: ', '')}",
                                                        );
                                                      }
                                                    }
                                                  } else {
                                                    SnackBars.showErroredGetSnackBar(
                                                      context,
                                                      'Please enter correct amount to continue',
                                                    );
                                                  }
                                                },
                                                oncancel: () {
                                                  vm.showDisclaimer = false;
                                                  Navigator.pop(context);
                                                },
                                                content: AppConstants
                                                    .vestingDisclaimer,
                                                title: 'Disclaimer',
                                                canceltxt: 'Cancel',
                                                oktxt: 'Ok',
                                              ),
                                            );
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 1,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.white12,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: context.width * 0.02,
                                right: context.width * 0.02,
                                bottom: MediaQuery.of(
                                  context,
                                ).viewInsets.bottom,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SB.h(20.h),
                                  CustomText(
                                    text: 'Purchase ZKTC',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28.sp,
                                    color: Colors.white,
                                  ),
                                  SB.h(5.h),
                                  CustomText(
                                    text: 'Buy tokens with fiat currency',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.sp,
                                    color: Colors.grey,
                                  ),
                                  // SB.h(10.h),
                                  // CustomText(
                                  //   text: 'Wallet Address',
                                  //   fontWeight: FontWeight.w500,
                                  //   fontSize: 16.sp,
                                  //   color: Colors.white,
                                  // ),
                                  // SB.h(10.h),
                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //     vertical: 12.h,
                                  //     horizontal: 12.w,
                                  //   ),
                                  //   height: 50.h,
                                  //   width: context.width,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(12.r),
                                  //     color: Colors.white10,
                                  //   ),
                                  //   child: CustomText(
                                  //     text: vm.walletAddress,
                                  //     fontWeight: FontWeight.w400,
                                  //     fontSize: 16.sp,
                                  //     color: Colors.white,
                                  //     textOverflow: TextOverflow.ellipsis,
                                  //   ),
                                  // ),
                                  // SB.h(10.h),
                                  // CustomButton(
                                  //   text: 'Wallet Connected',
                                  //   fontSize: 16.sp,
                                  //   fontWeight: FontWeight.w500,
                                  //   buttonColor: AppColors.btnColor,
                                  //   textColor: Colors.white,
                                  //   borderRadius: 12.r,
                                  // ),
                                  SB.h(10.h),
                                  CustomText(
                                    text: 'Amount in USD',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                  ),
                                  SB.h(10.h),
                                  Form(
                                    key: vm.fiatKey,
                                    child: CustomTextField(
                                      validatorFunction: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "Amount is required";
                                        }
                                        final parsed = double.tryParse(value);
                                        if (parsed == null) {
                                          return "Enter a valid number";
                                        }
                                        if (parsed <= 0) {
                                          return "Amount must be greater than zero";
                                        }
                                        return null;
                                      },
                                      controller: vm.amountCtrl,
                                      keyboardType: TextInputType.number,
                                      showBorders: false,
                                      backgroundColor: Colors.white10,
                                      cursorColor: Colors.white,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      hintText: "",
                                      onChanged: (value) {
                                        final amount =
                                            double.tryParse(value) ?? 0;
                                        if (amount > 1000) {
                                          // allow editing donation
                                        } else {
                                          vm.donationCtrl.text = "2.5";
                                          vm.donationPercentage = 2.5;
                                        }

                                        vm.update();
                                      },
                                    ),
                                  ),

                                  if ((double.tryParse(vm.amountCtrl.text) ??
                                          0) >
                                      1000) ...[
                                    SB.h(15.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 18.h,
                                        horizontal: 8.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        border: Border.all(
                                          width: 0.1,
                                          color: Colors.white60,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SB.h(15.h),
                                          CustomText(
                                            text:
                                                "Donation Percentage: ${vm.donationPercentage.toStringAsFixed(1)}%",
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                          SB.h(15.h),
                                          SliderTheme(
                                            data: SliderTheme.of(context).copyWith(
                                              trackHeight:
                                                  8.0, // thickness of slider track
                                              thumbShape:
                                                  const RoundSliderThumbShape(
                                                    enabledThumbRadius: 8,
                                                  ), // bigger thumb
                                              overlayShape:
                                                  const RoundSliderOverlayShape(
                                                    overlayRadius: 18,
                                                  ), // ripple around thumb
                                              activeTrackColor: Colors.blue,
                                              inactiveTrackColor:
                                                  Colors.grey[300],
                                              thumbColor: Colors.blue,
                                              valueIndicatorColor:
                                                  Colors.blueAccent,
                                            ),
                                            child: Slider(
                                              padding: EdgeInsets.all(0),
                                              value: vm.donationPercentage,
                                              thumbColor: AppColors.textBlue,
                                              activeColor: AppColors.btnColor,
                                              inactiveColor: Colors.white12,

                                              min: 1.0,
                                              max: 10.0,
                                              divisions: 90, // gives step = 0.1
                                              label: vm.donationPercentage
                                                  .toStringAsFixed(1),
                                              onChanged: (value) =>
                                                  vm.setDonation(value),
                                            ),
                                          ),
                                          SB.h(15.h),
                                          // Scale under the slider (only show major ticks for clarity)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                              10,
                                              (index) => CustomText(
                                                text:
                                                    "${(index + 1).toDouble().toStringAsFixed(1)}",
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  SB.h(20.h),
                                  Container(
                                    width: context.width,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 18.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Colors.white10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: 'You Receive',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color: Colors.grey,
                                        ),
                                        // SB.h(5.h),
                                        CustomText(
                                          text:
                                              (vm.defaultTokenRate == null ||
                                                  vm.zktcPrice == null)
                                              ? '--'
                                              : vm.amountCtrl.text.isNotEmpty
                                              ? '${(((double.parse(vm.amountCtrl.text) * vm.defaultTokenRate!) / vm.zktcPrice!) - (((double.parse(vm.amountCtrl.text) * vm.defaultTokenRate!) / vm.zktcPrice!) * vm.donationPercentage / 100)).toStringAsFixed(1)} ZKTC'
                                              : '0.0 ZKTC',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24.sp,
                                          color: Colors.white,
                                          textOverflow: TextOverflow.ellipsis,
                                        ),
                                        SB.h(10.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              text: 'Donated Amount',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp,
                                              color: Colors.grey,
                                            ),
                                            SB.w(5.w),
                                            CustomText(
                                              text: vm.zktcPrice == null
                                                  ? '--'
                                                  : vm
                                                        .amountCtrl
                                                        .text
                                                        .isNotEmpty
                                                  ? '${((double.parse(vm.amountCtrl.text) / vm.zktcPrice!) * vm.donationPercentage / 100).toStringAsFixed(1)} ZKTC'
                                                  : '0.0 ZKTC',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp,
                                              color: Colors.grey,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SB.h(10.h),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          vm.agreeToTerms = !vm.agreeToTerms;
                                        },
                                        child: Container(
                                          width: 18.0
                                              .w, // Set the width and height to match a checkbox size
                                          height: 18.h,
                                          decoration: BoxDecoration(
                                            color: vm.agreeToTerms
                                                ? AppColors.btnColor
                                                : Colors
                                                      .white, // Fill color based on state
                                            border: Border.all(
                                              color: vm.agreeToTerms
                                                  ? AppColors.btnColor
                                                  : Colors
                                                        .white, // Border color based on state
                                              width: 1.0, // Border thickness
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              4.0,
                                            ), // Optional: rounded corners
                                          ),
                                          child: vm.agreeToTerms
                                              ? Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 14.sp,
                                                )
                                              : null, // No icon if unchecked
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      CustomText(
                                        text: 'Agree to terms & conditions',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  SB.h(10.h),
                                  CustomButton(
                                    text: vm.paymentReady
                                        ? 'Pay \$ ${double.parse(vm.amountCtrl.text).toStringAsFixed(1)}'
                                        : 'Buy Now',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    buttonColor: AppColors.btnColor,
                                    textColor: Colors.white,
                                    borderRadius: 12.r,
                                    isLoading: vm.loading,
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (builder) => CustomConfirmationDialogue(
                                          onOk: () {
                                            vm.showDisclaimer = true;
                                            Navigator.pop(context);
                                            if (vm.paymentReady) {
                                              vm.makePayment();
                                            } else {
                                              log('buying intent');
                                              if (vm.fiatKey.currentState!
                                                  .validate()) {
                                                if (vm.agreeToTerms) {
                                                  vm.createPaymentIntent();
                                                } else {
                                                  SnackBars.showErroredGetSnackBar(
                                                    context,
                                                    'Please agree to terms & conditions',
                                                  );
                                                }
                                              } else {
                                                SnackBars.showErroredGetSnackBar(
                                                  context,
                                                  'Please enter correct amount to continue',
                                                );
                                              }
                                            }
                                          },
                                          oncancel: () {
                                            vm.showDisclaimer = false;
                                            Navigator.pop(context);
                                          },
                                          content:
                                              AppConstants.vestingDisclaimer,
                                          title: 'Disclaimer',
                                          canceltxt: 'Cancel',
                                          oktxt: 'Ok',
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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

  void _showWalletMenu(BuildContext context, PaymentVm vm) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    _buildMenuOption(
                      icon: Icons.logout,
                      title: 'Disconnect',
                      color: Colors.red,
                      onTap: () {
                        Navigator.pop(context);
                        // Add disconnect functionality here
                        vm.disconnectWallet();
                      },
                    ),
                    SizedBox(height: 16.h),
                    _buildMenuOption(
                      icon: Icons.explore,
                      title: 'View on Explorer',
                      color: Colors.black,
                      onTap: () {
                        Navigator.pop(context);
                        vm.launchBlockchainUrlsForAddress(
                          'ethereum',
                          AppConstants.walletAddress,
                        );
                        // Add view on explorer functionality here
                      },
                    ),
                    SizedBox(height: 16.h),
                    _buildMenuOption(
                      icon: Icons.copy,
                      title: 'Copy Address',
                      color: Colors.black,
                      onTap: () {
                        Navigator.pop(context);
                        Clipboard.setData(
                          ClipboardData(text: AppConstants.walletAddress),
                        );
                        SnackBars.showErroredGetSnackBar(
                          context,
                          'Address copied to clipboard',
                        );
                        // Add copy address functionality here
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24.sp),
            SizedBox(width: 16.w),
            CustomText(
              text: title,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
