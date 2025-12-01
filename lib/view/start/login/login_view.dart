import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:provider/provider.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/view/start/importCreateSelection/importCreateSelection_view.dart';
import 'package:zakat/view/start/login/login_vm.dart';
import 'package:zakat/view/start/signUp/signUp_view.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/custom_textfield.dart';
import 'package:zakat/widgets/formValidation.dart';
import 'package:zakat/widgets/sb.dart';

class LoginScreen extends StatelessWidget {
  static const String route = '/loginScreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginVm>(
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SizedBox(
                  height: context.height,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 80,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'login'.toSvgPath,
                                width: 310.w,
                                height: 222.h,
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: context.height * 0.08,
                          ),
                          child: Form(
                            key: vm.formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: AutofillGroup(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Email',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    validatorFunction: (value) {
                                      return Validation.validateEmail(value!);
                                    },
                                    controller: vm.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    showBorders: false,
                                    backgroundColor: Colors.white,
                                    hintText: "Enter email",
                                    autofillHints: const [AutofillHints.email],
                                  ),
                                  const SizedBox(height: 20),
                                  CustomText(
                                    text: 'Password',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    validatorFunction: (value) {
                                      return value!.isEmpty
                                          ? 'Please enter your password'
                                          : null;
                                    },
                                    controller: vm.passwordController,
                                    showBorders: false,
                                    obscureText: vm.hidePassword,
                                    backgroundColor: Colors.white,
                                    autofillHints: const [
                                      AutofillHints.password,
                                    ],
                                    hintText: "Enter password",
                                    suffixWidget: IconButton(
                                      onPressed: () => vm.toggleHidePassword(),
                                      icon: Icon(
                                        vm.hidePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              vm.keepSignIn = !vm.keepSignIn;
                                            },
                                            child: Container(
                                              width: 18.0
                                                  .w, // Set the width and height to match a checkbox size
                                              height: 18.h,
                                              decoration: BoxDecoration(
                                                color: vm.keepSignIn
                                                    ? AppColors.btnColor
                                                    : Colors
                                                          .white, // Fill color based on state
                                                border: Border.all(
                                                  color: vm.keepSignIn
                                                      ? AppColors.btnColor
                                                      : Colors
                                                            .white, // Border color based on state
                                                  width:
                                                      1.0, // Border thickness
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      4.0,
                                                    ), // Optional: rounded corners
                                              ),
                                              child: vm.keepSignIn
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
                                            text: 'Remember me for 30 days',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        child: CustomText(
                                          text: 'Forgot Password?',
                                          textDecoration:
                                              TextDecoration.underline,
                                          decorationColor: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.btnColor,
                                        ),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                   SB.h(20.h),
                                  CustomButton(
                                    onTap: () {
                                      if(vm.formKey.currentState!.validate()){
                                        vm.login();
                                      }
                                     
                                    },
                                    isLoading: vm.isLoading,
                                    text: 'Sign in',
                                    height: 44.h,
                                    buttonColor: AppColors.btnColor,
                                    borderRadius: 8.r,
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          Navigator.pushNamed(context, SignupView.route);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: "Don't have an account? ",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: "Sign up",
                                                    style: TextStyle(
                                                      color: AppColors.btnColor,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                    
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
