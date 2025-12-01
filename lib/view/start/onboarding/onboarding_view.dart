import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/view/start/login/login_view.dart';
import 'package:zakat/view/start/onboarding/onboarding_vm.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:zakat/widgets/sb.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  static const String route = '/OnboardingView';

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingVm>(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Stack(
          children: [
            Positioned(
                  bottom: -context.height*0.15,
                  child: Image.asset('wave'.toPngPath, width: context.width, )),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SB.h(2),
                SvgPicture.asset('onboard'.toSvgPath, width: 150.w, height: 135.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: context.width*0.08),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text:
                            'وَأَقِيمُواْ ٱلصَّلَوٰةَ وَءَاتُواْ ٱلزَّكَوٰةَ وَٱرۡكَعُواْ مَعَ ٱلرَّـٰكِعِينَ',
                        fontSize: 18.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                      SB.h(20.h),
                      CustomButton(
                        text: 'Get Started',
                        buttonColor: Colors.white,
                        borderRadius: 12.r,
                        textColor: Colors.black,
                        height: 50.h,
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.route);
                        },
                      ),
                      SB.h(20.h),
                      RichText(
  textAlign: TextAlign.center,
  text: TextSpan(
    style: TextStyle(
      fontSize: 10.sp,
      color: Colors.grey,
      fontWeight: FontWeight.w500,
      fontFamily: 'Rajdhani',
    ),
    children: [
      const TextSpan(text: 'By tapping "Get Started" you agree and consent to our '),
      TextSpan(
        text: 'Terms of Service',
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      const TextSpan(text: ' and '),
      TextSpan(
        text: 'Privacy Policy',
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ],
  ),
),

                      SB.h(20.h),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
