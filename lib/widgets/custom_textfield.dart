import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final FontWeight? fontWeight;
  final FontWeight? hintFontWeight;
  final String? fontFamily;
  final double? fontSize;
  final Color? color;
  final Color? cursorColor;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final dynamic icon;
  final bool? obscureText;
  final bool? isReadOnly;
  final Widget? suffixWidget;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? prefixPadding;
  final double? textPadding;
  final int? maxLines;
  final int? minLines;
  final TextAlign? textAlign;
  final bool showBorders;
  final Color? borderColor;
  final Function()? suffixFunction;
  final Function()? onTap;
  final String? Function(String?)? validatorFunction;
  final FocusNode? focusNode;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final bool? showUnderline;
  final Color? underlineColor;
  final Color? hintColor;
  final bool? expands;
  final List<String>? autofillHints;
  final AutovalidateMode? autoValidateMode;
  final GlobalKey<FormFieldState>? formKey;

  const CustomTextField(
      {super.key,
      this.onChanged,
      this.cursorColor,
      this.onTap,
      this.hintColor,
      this.controller,
      this.hintText,
      this.keyboardType,
      this.fontWeight,
      this.hintFontWeight,
      this.fontSize,
      this.color,
      this.icon,
      this.obscureText,
      this.suffixWidget,
      this.borderRadius,
      this.backgroundColor,
      required this.showBorders,
      this.textAlign,
      this.borderColor,
      this.suffixFunction,
      this.validatorFunction,
      this.fontFamily,
      this.isReadOnly,
      this.prefixPadding,
      this.maxLines,
      this.minLines,
      this.inputFormatters,
      this.focusNode,
      this.initialValue,
      this.textPadding,
      this.showUnderline,
      this.underlineColor,
      this.expands,
      this.autofillHints,
        this.formKey,
      this.autoValidateMode});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
      key: widget.formKey,
      onTap: widget.onTap ?? () {},
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      autovalidateMode: widget.autoValidateMode?? AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      autofillHints: widget.autofillHints,
      obscureText: widget.obscureText ?? false,
      readOnly: widget.isReadOnly ?? false,
      minLines: widget.minLines,
      cursorColor: widget.cursorColor ?? Colors.white,
      maxLines: widget.maxLines ?? 1,
      expands: widget.expands ?? false,
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign ?? TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      validator: widget.validatorFunction,
      inputFormatters: widget.inputFormatters ?? [],
      style: TextStyle(
          color: widget.color ?? Colors.black,
          fontWeight: widget.fontWeight ?? FontWeight.normal,
          fontSize: widget.fontSize ?? 16.sp,
          fontFamily: widget.fontFamily ?? 'Rajdhani'),
      decoration: InputDecoration(
        fillColor: widget.backgroundColor ?? Colors.transparent,
        filled: widget.backgroundColor == null ? false : true,
        enabledBorder: widget.showUnderline == true
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color:
                        widget.underlineColor ?? Colors.white.withOpacity(0.3)))
            : OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.showBorders == true
                        ? widget.borderColor ?? Colors.white.withOpacity(0.3)
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
              ),
        focusedBorder: widget.showUnderline == true
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color:
                        widget.underlineColor ?? Colors.white.withOpacity(0.3)))
            : OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.showBorders == true
                        ? widget.borderColor ?? Colors.white.withOpacity(0.3)
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
              ),
        errorBorder: widget.showUnderline == true
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color:
                        widget.underlineColor ?? Colors.white.withOpacity(0.3)))
            : OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.showBorders == true
                        ? widget.borderColor ?? Colors.white.withOpacity(0.3)
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
              ),
        focusedErrorBorder: widget.showUnderline == true
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color:
                        widget.underlineColor ?? Colors.white.withOpacity(0.3)))
            : OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.showBorders == true
                        ? widget.borderColor ?? Colors.white.withOpacity(0.3)
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
              ),
        prefixIcon: widget.icon != null
            ? Padding(
                padding: EdgeInsetsDirectional.only(
                    start: widget.textPadding ?? 20.w,
                    end: widget.prefixPadding ??
                        12.0.w), // Adjust padding to give space
                child: widget.icon,
              )
            : null,
        prefixIconConstraints: BoxConstraints(
          minWidth: widget.textPadding ?? 23.w,
          minHeight: widget.textPadding ?? 16.h,
        ),
        suffixIcon: widget.suffixWidget != null
            ? GestureDetector(
                onTap: widget.suffixFunction,
                child: Padding(
                  padding: EdgeInsets.only(right: 12.0.w),
                  child: widget.suffixWidget,
                ),
              )
            : null,
        suffixIconConstraints: BoxConstraints(
          minWidth: 23.w,
          minHeight: 16.h,
        ),
        alignLabelWithHint: false,
        contentPadding: EdgeInsets.only(
            bottom: 14.h,
            left: widget.icon == null ? widget.textPadding ?? 20.w : 0.w),
        border: InputBorder.none,
        hintText: widget.hintText ?? 'Enter your email',
        hintStyle: TextStyle(
            color: widget.hintColor ?? Colors.grey,
            fontSize: widget.fontSize ?? 16.sp,
            fontWeight: widget.hintFontWeight?? FontWeight.w400,
            fontFamily: widget.fontFamily ?? 'Rajdhani'),
            
  
      ),
    );
  }
}


class CustomTextField2 extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final Color? color;
  final Color? cursorColor;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final dynamic icon;
  final bool? obscureText;
  final bool? isReadOnly;
  final Widget? suffixWidget;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? prefixPadding;
  final double? textPadding;
  final int? maxLines;
  final int? minLines;
  final TextAlign? textAlign;
  final bool showBorders;
  final Color? borderColor;
  final Function()? suffixFunction;
  final Function()? onTap;
  final String? Function(String?)? validatorFunction;
  final FocusNode? focusNode;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final bool? showUnderline;
  final Color? underlineColor;
  final Color? hintColor;
  final bool? expands;
  final List<String>? autofillHints;
  final AutovalidateMode? autoValidateMode;
  final GlobalKey<FormFieldState>? formKey;

  const CustomTextField2(
      {super.key,
        this.onChanged,
        this.cursorColor,
        this.onTap,
        this.hintColor,
        this.controller,
        this.hintText,
        this.keyboardType,
        this.fontWeight,
        this.fontSize,
        this.color,
        this.icon,
        this.obscureText,
        this.suffixWidget,
        this.borderRadius,
        this.backgroundColor,
        required this.showBorders,
        this.textAlign,
        this.borderColor,
        this.suffixFunction,
        this.validatorFunction,
        this.fontFamily,
        this.isReadOnly,
        this.prefixPadding,
        this.maxLines,
        this.minLines,
        this.inputFormatters,
        this.focusNode,
        this.initialValue,
        this.textPadding,
        this.showUnderline,
        this.underlineColor,
        this.expands,
        this.autofillHints,
        this.formKey,
        this.autoValidateMode});

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
      key: widget.formKey,
      onTap: widget.onTap ?? () {},
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      autovalidateMode: widget.autoValidateMode?? AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      autofillHints: widget.autofillHints,
      obscureText: widget.obscureText ?? false,
      readOnly: widget.isReadOnly ?? false,
      minLines: widget.minLines,
      cursorColor: widget.cursorColor ?? Colors.black,
      maxLines: widget.maxLines,
      expands: widget.expands ?? false,
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign ?? TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      validator: widget.validatorFunction,
      inputFormatters: widget.inputFormatters ?? [],
      style: TextStyle(
          color: widget.color ?? Colors.black,
          fontWeight: widget.fontWeight ?? FontWeight.normal,
          fontSize: widget.fontSize ?? 16.sp,
          fontFamily: widget.fontFamily ?? 'Metropolis'),
      decoration: InputDecoration(
        fillColor: widget.backgroundColor ?? Colors.transparent,
        filled: widget.backgroundColor == null ? false : true,
        enabledBorder: widget.showUnderline == true
            ? UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                widget.underlineColor ?? Colors.black.withOpacity(0.3)))
            : OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.showBorders == true
                  ? widget.borderColor ?? Colors.black.withOpacity(0.3)
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
        ),
        focusedBorder: widget.showUnderline == true
            ? UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                widget.underlineColor ?? Colors.black.withOpacity(0.3)))
            : OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.showBorders == true
                  ? widget.borderColor ?? Colors.black.withOpacity(0.3)
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
        ),
        errorBorder: widget.showUnderline == true
            ? UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                widget.underlineColor ?? Colors.black.withOpacity(0.3)))
            : OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.showBorders == true
                  ? widget.borderColor ?? Colors.black.withOpacity(0.3)
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
        ),
        focusedErrorBorder: widget.showUnderline == true
            ? UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                widget.underlineColor ?? Colors.black.withOpacity(0.3)))
            : OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.showBorders == true
                  ? widget.borderColor ?? Colors.black.withOpacity(0.3)
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
        ),
        prefixIcon: widget.icon != null
            ? Padding(
          padding: EdgeInsetsDirectional.only(
              start: widget.textPadding ?? 20.w,
              end: widget.prefixPadding ??
                  12.0.w), // Adjust padding to give space
          child: widget.icon,
        )
            : null,
        prefixIconConstraints: BoxConstraints(
          minWidth: widget.textPadding ?? 23.w,
          minHeight: widget.textPadding ?? 16.h,
        ),
        suffixIcon: widget.suffixWidget != null
            ? GestureDetector(
          onTap: widget.suffixFunction,
          child: Padding(
            padding: EdgeInsets.only(right: 12.0.w),
            child: widget.suffixWidget,
          ),
        )
            : null,
        suffixIconConstraints: BoxConstraints(
          minWidth: 23.w,
          minHeight: 16.h,
        ),
        alignLabelWithHint: false,
        contentPadding: EdgeInsets.only(
            bottom: 14.h,
            left: widget.icon == null ? widget.textPadding ?? 20.w : 0.w),
        border: InputBorder.none,
        hintText: widget.hintText ?? 'Enter your email',
        hintStyle: TextStyle(
            color: widget.hintColor ?? Colors.black,
            fontSize: widget.fontSize ?? 16.sp,
            fontWeight:  FontWeight.w400,
            fontFamily: widget.fontFamily ?? 'Metropolis'),


      ),
    );
  }
}

