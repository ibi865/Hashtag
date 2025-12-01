import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/view/start/signUp/signUp_vm.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/custom_textfield.dart';
import 'package:zakat/widgets/formValidation.dart';
import 'package:zakat/widgets/sb.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupVm>(
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SizedBox(
                  height: context.height,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.06,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                              'login'.toSvgPath,
                              width: 120.w,
                              height: 120.h,
                            ),
                        Form(
                          key: vm.formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: AutofillGroup(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                CustomText(
                                  text: 'First Name',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  validatorFunction: (val) => val!.isEmpty
                                      ? "First name required"
                                      : null,
                                  controller: vm.firstNameController,
                                  keyboardType: TextInputType.name,
                                  showBorders: false,
                                  backgroundColor: Colors.white,
                                  hintText: "Enter first name",
                                  autofillHints: const [AutofillHints.name],
                                ),
                                const SizedBox(height: 20),
                                CustomText(
                                  text: 'Last Name',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  validatorFunction: (val) =>
                                      val!.isEmpty ? "Username required" : null,
                                  controller: vm.lastNameController,
                                  keyboardType: TextInputType.name,
                                  showBorders: false,
                                  backgroundColor: Colors.white,
                                  hintText: "Enter last name",
                                  autofillHints: const [AutofillHints.name],
                                ),
                                const SizedBox(height: 20),
                                CustomText(
                                  text: 'Username',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  validatorFunction: (val) =>
                                      val!.isEmpty ? "Username required" : null,
                                  controller: vm.userNameController,
                                  keyboardType: TextInputType.name,
                                  showBorders: false,
                                  backgroundColor: Colors.white,
                                  hintText: "Enter username",
                                  autofillHints: const [AutofillHints.name],
                                ),
                                const SizedBox(height: 20),
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
                                  autofillHints: const [AutofillHints.password],
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
                                SB.h(20.h),
                                CustomButton(
                                  onTap: () {
                                    if (vm.formKey.currentState!.validate()) {
                                      vm.signup();
                                    }
                                  },
                                  isLoading: vm.isLoading,
                                  text: 'Sign Up',
                                  height: 44.h,
                                  buttonColor: AppColors.btnColor,
                                  borderRadius: 8.r,
                                ),
                                SB.h(20.h),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Already have an account? ",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "Sign in",
                                            style: TextStyle(
                                              color: AppColors.btnColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            // recognizer: TapGestureRecognizer()
                                            //   ..onTap = () => Navigator.pushNamed(context, LoginScreen.route),
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

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? hint,
    String? Function(String?)? validator,
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
    Widget? suffix,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: label,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: controller,
            hintText: hint,
            validatorFunction: validator,
            obscureText: obscure,
            showBorders: false,
            backgroundColor: Colors.white,
            autofillHints: const [AutofillHints.name],
            keyboardType: keyboard,
            suffixWidget: suffix,
          ),
        ],
      ),
    );
  }
}
