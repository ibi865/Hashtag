import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/color_resources.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../view_model/screen_b_vm.dart';
import '../../config/app_routes.dart';

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Consumer<ScreenBVm>(
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.primary,
            title: CustomText(
              text: l10n.screenB,
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
            child: !vm.hasData
                ? _buildEmptyState(context, vm, l10n)
                : _buildDataState(context, vm, l10n),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, ScreenBVm vm, AppLocalizations l10n) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
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
                      Icons.edit_note,
                      size: 60.sp,
                      color: AppColors.btnColor,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  CustomText(
                    text: 'Ready to Create',
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                    text: 'Add your phrase and hashtags',
                    fontSize: 16.sp,
                    color: Colors.white70,
                  ),
                  SizedBox(height: 50.h),
                  _buildFeatureCard(
                    icon: Icons.text_fields,
                    title: 'Write Your Phrase',
                    description: 'Type your thoughts and ideas',
                    color: AppColors.btnColor,
                  ),
                  SizedBox(height: 20.h),
                  _buildFeatureCard(
                    icon: Icons.tag,
                    title: 'Add Hashtags',
                    description: 'Hashtags will be highlighted automatically',
                    color: Colors.purple,
                  ),
                  SizedBox(height: 20.h),
                  _buildFeatureCard(
                    icon: Icons.auto_awesome,
                    title: 'Smart Detection',
                    description: 'Hashtags are extracted automatically',
                    color: Colors.orange,
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
                      onTap: () => vm.navigateToScreenC(context, AppRoutes.screenC),
                      text: l10n.navigateToScreenC,
                      height: 56.h,
                      buttonColor: AppColors.btnColor,
                      borderRadius: 12.r,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: description,
                  fontSize: 14.sp,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataState(BuildContext context, ScreenBVm vm, AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            if (vm.phrase?.isNotEmpty ?? false) ...[
              _buildFormattedCard(
                text: vm.phrase!,
                label: l10n.phrase,
                icon: Icons.text_fields,
              ),
              SizedBox(height: 20.h),
            ],
            if (vm.hashtags?.isNotEmpty ?? false) ...[
              _buildFormattedCard(
                text: vm.hashtags!,
                label: l10n.hashtags,
                icon: Icons.tag,
              ),
              SizedBox(height: 20.h),
            ],
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: CustomButton(
                onTap: () => vm.navigateBackToScreenA(context),
                text: l10n.done,
                height: 56.h,
                buttonColor: Colors.green,
                borderRadius: 12.r,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFormattedCard({
    required String text,
    required String label,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.btnColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  color: AppColors.btnColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomText(
                  text: label,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildTextWithHighlightedHashtags(text),
        ],
      ),
    );
  }

  Widget _buildTextWithHighlightedHashtags(String text) {
    final hashtagRegex = RegExp(r'#\w+');
    final matches = hashtagRegex.allMatches(text);
    
    if (matches.isEmpty) {
      return CustomText(
        text: text,
        fontSize: 16.sp,
        color: Colors.white,
      );
    }

    final textSpans = <TextSpan>[];
    int lastIndex = 0;

    for (final match in matches) {
      if (match.start > lastIndex) {
        textSpans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontFamily: 'Rajdhani',
              height: 1.5,
            ),
          ),
        );
      }

      final hashtag = match.group(0)!;
      final hashtagColor = AppColors.getHashtagColor(hashtag);

      textSpans.add(
        TextSpan(
          text: hashtag,
          style: TextStyle(
            fontSize: 16.sp,
            color: hashtagColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
            height: 1.5,
          ),
        ),
      );

      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      textSpans.add(
        TextSpan(
          text: text.substring(lastIndex),
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontFamily: 'Rajdhani',
            height: 1.5,
          ),
        ),
      );
    }

    return RichText(
      text: TextSpan(children: textSpans),
    );
  }
}
