import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/color_resources.dart';

class CacheImage extends StatelessWidget {
  final String link;
  final String name;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  final BoxShape? shape;
  final Color? borderColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BoxFit? boxFit;
  const CacheImage({
    super.key,
    required this.link,
    required this.name,
    this.width,
    this.height,
    this.borderColor,
    this.radius,
    this.color,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.shape,
    this.boxFit
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: shape ?? BoxShape.circle,
          border: Border.all(
              width: borderColor == null ? 0 : 3,
              color: borderColor ?? Colors.transparent)),
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: CachedNetworkImage(
          memCacheWidth: 300,  // Ensure a higher resolution
          memCacheHeight: 300,
          filterQuality: FilterQuality.low,
          fadeInDuration: const Duration(milliseconds: 100),
          fit: boxFit ?? BoxFit.cover,
          imageUrl: link,
          progressIndicatorBuilder: (context, url, downloadProgress){
             return  const Center(
                  child: CircularProgressIndicator(
            color: Colors.orange,
          ));},
          errorWidget: (context, url, dynamic error) => Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: shape ?? BoxShape.circle,
              // borderRadius: BorderRadius.circular(360),
              color: AppColors.bgColor,
              
            ),
            child: Center(
              child: Text(
                // (name != null && name.isNotEmpty) ? name[0].toUpperCase() : '', // Null and empty check
               getInitials(name),
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: fontWeight ?? FontWeight.w500,
                  fontSize: fontSize ?? 18,
                ),
              ),
            ),

          ),
        ),
      ),
    );
  }

  String getInitials(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isNotEmpty) {
      final words = trimmedName.split(' ').where((word) => word.isNotEmpty).toList();
      if (words.length > 1) {
        // Get the first character of the first two words
        return "${words[0][0].toUpperCase()}${words[1][0].toUpperCase()}";
      } else {
        // Get the first character of the single word
        return words[0][0].toUpperCase();
      }
    }
    return ''; // Fallback for empty name
  }

}

class CacheImageTwo extends StatelessWidget {
  final String link;
  final String name;
  final double? radius;
  final BoxFit? fit;
  final Color? back;
  const CacheImageTwo({
    super.key,
    this.back,
    required this.link,
    required this.name,
    this.fit,
    this.radius,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        fit: fit ?? BoxFit.fill,
        imageUrl: link,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const CircularProgressIndicator(),
        errorWidget: (context, url, dynamic error) => Container(
          decoration:  BoxDecoration(
            color: back ?? Colors.white,
          ),
          child: Center(
            child: Text(
              name[0].toUpperCase(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
