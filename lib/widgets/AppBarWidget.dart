import 'package:flutter/material.dart';

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
      title : Text(text.toString()),
      backgroundColor: bgColor,
      actions: actions,
    );
  }
}



