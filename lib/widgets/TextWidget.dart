import 'package:flutter/material.dart';

import 'get_device_size.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final double? wordSpacing;
  final double? textScaleFactor;
  final TextAlign? textAlign;
  final int? lines;
  final String? fontFamily;

  const MyText({
    required this.text,
    this.size,
    this.fontWeight,
    this.fontColor,
    this.wordSpacing,
    this.textScaleFactor,
    this.textAlign,
    this.lines,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = GetDeviceSize.getDeviceSize(context);
    return Text(
      text.toString(),
      overflow: lines == 0 ? TextOverflow.visible : TextOverflow.ellipsis,
      textAlign: textAlign,
      maxLines: lines == 0 ? null : lines,
      style: TextStyle(
          fontSize: size,
          color: fontColor,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          decoration: TextDecoration.none
      ),
    );
  }
}



