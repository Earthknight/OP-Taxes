import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: size ?? 35.0,
        color: color ?? Colors.white,
      ),
    );
  }
}