import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/color_resources.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../view_model/screen_c_vm.dart';

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return ChangeNotifierProvider(
      create: (_) => ScreenCVm(),
      child: Consumer<ScreenCVm>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.primary,
              title: CustomText(
                text: l10n.screenC,
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
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        _buildFieldCard(
                          context: context,
                          label: l10n.phrase,
                          icon: Icons.text_fields,
                          child: _buildPhraseTextField(context, vm),
                        ),
                        SizedBox(height: 24.h),
                        _buildFieldCard(
                          context: context,
                          label: l10n.hashtags,
                          icon: Icons.tag,
                          child: _buildHashtagsTextField(context, vm),
                        ),
                        SizedBox(height: 40.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.btnColor.withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: CustomButton(
                            onTap: () => vm.submit(context),
                            text: l10n.submit,
                            height: 56.h,
                            buttonColor: AppColors.btnColor,
                            borderRadius: 12.r,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFieldCard({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Widget child,
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
              CustomText(
                text: label,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  Widget _buildPhraseTextField(BuildContext context, ScreenCVm vm) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            // Background text with highlighting
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 16.h,
                  bottom: 16.h,
                ),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: vm.phraseController,
                  builder: (context, value, child) {
                    if (value.text.isEmpty) {
                      return Text(
                        l10n.enterPhrase,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                          fontFamily: 'Rajdhani',
                          height: 1.5,
                        ),
                      );
                    }
                    return _buildHighlightedText(value.text);
                  },
                ),
              ),
            ),
            // Transparent text field for input
            TextField(
              controller: vm.phraseController,
              focusNode: vm.phraseFocusNode,
              maxLines: null,
              minLines: 5,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.transparent,
                fontFamily: 'Rajdhani',
                height: 1.5,
              ),
              decoration: InputDecoration(
                hintText: l10n.enterPhrase,
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.transparent,
                  fontFamily: 'Rajdhani',
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
              cursorColor: AppColors.btnColor,
              cursorWidth: 2.0,
              cursorRadius: const Radius.circular(1),
              showCursor: true,
              enableInteractiveSelection: true,
              selectionControls: MaterialTextSelectionControls(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHashtagsTextField(BuildContext context, ScreenCVm vm) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            // Background text with highlighting
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 16.h,
                  bottom: 16.h,
                ),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: vm.hashtagsController,
                  builder: (context, value, child) {
                    if (value.text.isEmpty) {
                      return Text(
                        l10n.enterHashtags,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                          fontFamily: 'Rajdhani',
                          height: 1.5,
                        ),
                      );
                    }
                    return _buildHighlightedHashtagsText(value.text);
                  },
                ),
              ),
            ),
            // Transparent text field for input
            TextField(
              controller: vm.hashtagsController,
              focusNode: vm.hashtagsFocusNode,
              maxLines: null,
              minLines: 3,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.transparent,
                fontFamily: 'Rajdhani',
                height: 1.5,
              ),
              decoration: InputDecoration(
                hintText: l10n.enterHashtags,
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.transparent,
                  fontFamily: 'Rajdhani',
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
              cursorColor: AppColors.btnColor,
              cursorWidth: 2.0,
              cursorRadius: const Radius.circular(1),
              showCursor: true,
              enableInteractiveSelection: true,
              selectionControls: MaterialTextSelectionControls(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText(String text) {
    final hashtagRegex = RegExp(r'#\w+');
    final matches = hashtagRegex.allMatches(text);

    if (matches.isEmpty) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontFamily: 'Rajdhani',
          height: 1.5,
        ),
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
              color: Colors.black,
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
            color: Colors.black,
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

  Widget _buildHighlightedHashtagsText(String text) {
    final hashtagRegex = RegExp(r'#\w+');
    final matches = hashtagRegex.allMatches(text);

    if (matches.isEmpty) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontFamily: 'Rajdhani',
          height: 1.5,
        ),
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
              color: Colors.black,
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
            color: Colors.black,
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
