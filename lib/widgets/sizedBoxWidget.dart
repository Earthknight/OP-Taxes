import 'package:flutter/material.dart';
import 'get_device_size.dart';

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
    final screenSize = GetDeviceSize.getDeviceSize(context);
    double fontSizeWidth = screenSize.width<=600 ? screenSize.width / 26 : screenSize.width / 38;
    double fontSizeHeight = screenSize.width<=600 ? screenSize.height / 26 : screenSize.height / 38;
    return Container(
      width: width == null ? 0.0 :  fontSizeWidth + (screenSize.width<=600 ? width : width! * 1.6 + 1)!.toDouble() ,
      height: height == null ? 0.0 :  fontSizeHeight + (screenSize.width<=600 ? height : height! * 1.6 + 1)!.toDouble() ,
      child: child,
    );
  }
}



