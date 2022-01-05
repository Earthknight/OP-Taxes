import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


Text MyText_lalu(var text,[double? fontSize, Color? fontColor = Colors.white, String ?fontFamily = "Georgia", FontWeight ? fontWeight]) {

  return Text(
    text.toString(),
    style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        decoration: TextDecoration.none
    ),
  );
}

// Widget Positioned2(){
//   return Positioned(child: Text(''),
//
//   );
//}