import 'package:flutter/material.dart';

class CustomCard {
  static Card getCard(
    Widget child, {
    EdgeInsetsGeometry? margin,
    double? elevation,
    ShapeBorder? shape,
    Color? shawdowColor,
    bool borderOnForeGround = true,
  }) {
    return Card(
      margin: margin,
      elevation: elevation,
      shape: shape,
      child: child,
      shadowColor: shawdowColor,
      borderOnForeground: borderOnForeGround,
    );
  }
}
