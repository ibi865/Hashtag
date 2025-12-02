import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/color_resources.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../view_model/screen_a_vm.dart';
import '../../config/app_routes.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return ChangeNotifierProvider(
      create: (_) => ScreenAVm(),
      child: Consumer<ScreenAVm>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.primary,
              title: CustomText(
                text: l10n.screenA,
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary,
                    AppColors.bgColor,
                  ],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(30.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.btnColor.withOpacity(0.2),
                              AppColors.btnColor.withOpacity(0.05),
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 60.sp,
                          color: AppColors.btnColor,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      CustomText(
                        text: 'Welcome',
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10.h),
                      CustomText(
                        text: 'Start your journey',
                        fontSize: 16.sp,
                        color: Colors.white70,
                      ),
                      SizedBox(height: 50.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.btnColor.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: CustomButton(
                          onTap: () => vm.navigateToScreenB(context, AppRoutes.screenB),
                          text: l10n.navigateToScreenB,
                          height: 56.h,
                          buttonColor: AppColors.btnColor,
                          borderRadius: 12.r,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
