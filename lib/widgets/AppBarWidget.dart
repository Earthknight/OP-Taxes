import 'package:flutter/material.dart';

import 'TextWidget.dart';

class MyAppBar extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final List<Widget>? actions;

  const MyAppBar({
    required this.text,
    this.bgColor,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title : MyText(text : text.toString(), size: 9.0, fontWeight: FontWeight.bold,),
      backgroundColor: bgColor,
      actions: actions,
    );
  }
}



