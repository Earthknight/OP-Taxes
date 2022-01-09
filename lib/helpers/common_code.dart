import 'package:flutter/material.dart';

// CLASS FOR COMMON CODE
class CommonCode {
  // STATIC METHOD TO RETURN THE SIZE OF DEVICE
  static Size getDeviceSize(BuildContext ctx) {
    return MediaQuery.of(ctx).size;
  }

  // STATIC METHOD TO SET THE MARGIN OR PADDING USING EDGEINSETS
  static EdgeInsetsGeometry setEgdeInsetsSymmteric(
    double horizontal,
    double vertical,
  ) {
    return EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: vertical,
    );
  }
}
