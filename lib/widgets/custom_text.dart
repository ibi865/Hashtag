import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final String? fontFamily;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final double? decorationthickness;

  const CustomText(
      {super.key,
      required this.text,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.textAlign,
      this.textDecoration,
      this.decorationColor,
        this.maxLines,
      this.fontFamily,
      this.textOverflow,
      this.decorationthickness});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
       
          fontSize: fontSize ?? 14.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? Colors.white,
          decoration: textDecoration,
          decorationColor: decorationColor,
          decorationThickness: decorationthickness,
          fontFamily: fontFamily ?? 'Rajdhani'),
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      overflow: textOverflow,
    );
  }
}

class ExpandableCustomText extends StatefulWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final String? fontFamily;
  final double? decorationthickness;
  final int maxLines; // Maximum lines to show when collapsed
  final VoidCallback? onShowMore; // Callback for Show More tap
  final VoidCallback? onShowLess; // Callback for Show Less tap

  const ExpandableCustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.textDecoration,
    this.decorationColor,
    this.fontFamily,
    this.decorationthickness,
    this.maxLines = 4, // Default to 4 lines
    this.onShowMore,
    this.onShowLess,
  });

  @override
  State<ExpandableCustomText> createState() => _ExpandableCustomTextState();
}

class _ExpandableCustomTextState extends State<ExpandableCustomText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Create a TextPainter to measure the text
        final textPainter = TextPainter(
          text: TextSpan(
            text: widget.text,
            style: TextStyle(
              fontSize: widget.fontSize ?? 16.sp,
              fontWeight: widget.fontWeight ?? FontWeight.w600,
              color: widget.color ?? Colors.black,
              decoration: widget.textDecoration,
              decorationColor: widget.decorationColor,
              decorationThickness: widget.decorationthickness,
              fontFamily: widget.fontFamily ?? 'Metropolis',
            ),
          ),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);

        // Check if text exceeds the specified number of lines
        final bool textExceedsMaxLines = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontSize: widget.fontSize ?? 16.sp,
                fontWeight: widget.fontWeight ?? FontWeight.w600,
                color: widget.color ?? Colors.black,
                decoration: widget.textDecoration,
                decorationColor: widget.decorationColor,
                decorationThickness: widget.decorationthickness,
                fontFamily: widget.fontFamily ?? 'Metropolis',
              ),
              maxLines: isExpanded ? null : widget.maxLines,
              textAlign: widget.textAlign ?? TextAlign.start,
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            if (textExceedsMaxLines)
              GestureDetector(
                onTap: () {
                  // Call the appropriate callback for navigation
                  if (isExpanded) {
                    widget.onShowLess?.call();
                  } else {
                    widget.onShowMore?.call();
                  }

                  // Don't update local state since we're navigating away
                  // setState(() {
                  //   isExpanded = !isExpanded;
                  // });
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    isExpanded ? 'View Less' : 'View More',
                    style: TextStyle(
                      fontSize: (widget.fontSize ?? 16.sp) - 2.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: widget.fontFamily ?? 'Metropolis',
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
