import 'package:flutter/material.dart';

class CustomBoxes {
  static SizedBox getSizedBox({
    double? width,
    double? height,
    Widget? child,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: child,
    );
  }

  static FittedBox getFittedBox(
    Widget child, {
    BoxFit boxFit = BoxFit.contain,
  }) {
    return FittedBox(
      child: child,
      fit: boxFit,
    );
  }
}
