import 'package:flutter/material.dart';

import 'get_device_size.dart';

class MyIcon extends StatelessWidget {
  MyIcon ({
    this.onTap,
    this.color = Colors.white,
    required this.icon,
    this.size
  });
  final VoidCallback? onTap;
  final Color? color;
  final IconData icon;
  final double? size;
  @override
  Widget build(BuildContext context) {
    final screenSize = GetDeviceSize.getDeviceSize(context);
    double fontSize = screenSize.width<=600 ? screenSize.width / 26 : screenSize.width / 38;
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: size == null ? 35.0 :  fontSize + (screenSize.width<=600 ? size : size! * 1.6 + 1)!.toDouble() ,
        color: color ?? Colors.white,
      ),
    );
  }
}