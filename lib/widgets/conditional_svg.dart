import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zakat/helper/string_helpers.dart';

Future<bool> assetExists(String path) async {
  try {
    // Try to load the asset
    await rootBundle.load(path);
    return true;
  } catch (e) {
    // If there's an error, the asset doesn't exist
    return false;
  }
}

class ConditionalSvgPicture extends StatelessWidget {
  final String assetPath;
  final Color color;
  final double height;
  final double width;

  const ConditionalSvgPicture({super.key,
    required this.assetPath,
    this.color = Colors.white,
    this.height = 25,
    this.width = 25,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: assetExists(assetPath),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return SvgPicture.asset(
            assetPath,
            colorFilter: ColorFilter.mode(color, BlendMode.dstIn),
            height: height,
            width: width,
          );
        } else {
          return SvgPicture.asset('logo'.toSvgPath,height: height,);
        }
      },
    );
  }
}
