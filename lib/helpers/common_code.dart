import 'package:flutter/material.dart';

class CommonCode {
  static Size getDeviceSize(BuildContext ctx) {
    return MediaQuery.of(ctx).size;
  }

  static EdgeInsetsGeometry setMarginSymmteric(
      double horizontal, double vertical) {
    return EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: vertical,
    );
  }
}
