import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/extension.dart';
import 'package:zakat/view/start/splash/splash_vm.dart';
import 'package:zakat/widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/SplashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashVm>(builder: (context, vm, _) {
      return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SafeArea(
            child: Stack(
              
              children: [
                Positioned(
                  bottom: 0,
                  child: Image.asset('wave'.toPngPath, width: context.width, )),
                Center(
                  child: Padding(
                    padding:  EdgeInsets.only(bottom: 150.h),
                    child: SvgPicture.asset(
                      'splash'.toSvgPath,
                      width: 150.w,
                      height: 135.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        
      );
    });
  }
}
