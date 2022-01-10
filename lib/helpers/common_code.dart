import 'package:flutter/material.dart';

class CommonCode {
  static Size getDeviceSize(BuildContext ctx) {
    return MediaQuery.of(ctx).size;
  }
}
