import 'package:flutter/material.dart';

class MySizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;

  const MySizedBox({
    this.height,
    this.width,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 0.0,
      width: width ?? 0.0,
      child: child,
    );
  }
}



