import 'package:flutter/material.dart';

class CustomCircleAvater {
  static CircleAvatar getCircleAvatar(
    Widget child,
    double radius,
    Color bgColor, {
    ImageProvider<Object>? backgroundImage,
    ImageProvider<Object>? foregroundImage,
    Color? fgColor,
    double? minRadius,
    double? maxRadius,
  }) {
    return CircleAvatar(
      backgroundColor: bgColor,
      child: child,
      radius: radius,
      backgroundImage: backgroundImage,
      foregroundImage: foregroundImage,
      foregroundColor: fgColor,
      minRadius: minRadius,
      maxRadius: maxRadius,
    );
  }
}
