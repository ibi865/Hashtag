import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/view/start/connectBank/connectBank_vm.dart';
import 'package:zakat/view/dash_mains/convert/convert_view.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/custom_textfield.dart';
import 'package:zakat/widgets/formValidation.dart';
import 'package:zakat/widgets/sb.dart';

class ConnectbankView extends StatelessWidget {
  const ConnectbankView({super.key});
  static const String route = '/ConnectbankView';

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectbankVm>(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: context.height * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Connect Your Bank Account',
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,

                        color: Colors.white,
                      ),

                      const SizedBox(height: 10),
                      CustomText(
                        text:
                            'To enable fiat deposits and withdrawals, please connect your verified local bank account to your wallet.',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,

                        color: Colors.white,
                      ),

                      Form(
                        key: vm.formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: AutofillGroup(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Name',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontFamily: 'Rajdhani',
                                      ),
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.top,
                                      child: Text(
                                        '*',
                                        style: TextStyle(
                                          fontSize:
                                              10.sp, // smaller for superscript
                                          color: Colors
                                              .white, // usually asterisk is red
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Rajdhani',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 10),
                              CustomTextField(
                                validatorFunction: (value) {
                                  return Validation.validateEmail(value!);
                                },
                                controller: vm.name,
                                keyboardType: TextInputType.emailAddress,
                                showBorders: false,
                                backgroundColor: Colors.white,
                                hintText: "Enter your account name",
                                autofillHints: const [AutofillHints.email],
                              ),
                              const SizedBox(height: 20),
                              CustomText(
                                text: 'Iban',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                validatorFunction: (value) {
                                  return value!.isEmpty
                                      ? 'Please enter your Iban'
                                      : null;
                                },
                                controller: vm.iban,
                                showBorders: false,
                                backgroundColor: Colors.white,
                                autofillHints: const [AutofillHints.password],
                                hintText: "Enter your Iban",
                              ),

                              const SizedBox(height: 20),
                              CustomButton(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   ConvertView.route,
                                  // );
                                },
                                // isLoading: vm.isLoading,
                                text: 'Submit',
                                height: 40.h,
                                buttonColor: AppColors.btnColor,
                                borderRadius: 8.r,
                                fontSize: 14.sp,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                CustomText(
                  text:
                      'To enable fiat deposits and withdrawals, please connect your verified local bank account to your wallet.Ensure that the account is in your name. Third-party accounts are not supported and may be rejected.',
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 10.sp,
                  textAlign: TextAlign.center,
                ),
                SB.h(10.h),
                CustomText(
                  text:
                      'Processing may take 1–2 business days for verification.',
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 10.sp,
                  textAlign: TextAlign.center,
                ),
                SB.h(30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
