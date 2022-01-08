import 'package:flutter/material.dart';
import 'custom_boxes.dart';
import 'custom_circle_avater.dart';

class CustomCircularIcon {
  static Widget getCircularIcon(
    double radius, {
    String text = 'default',
    Color bgColor = Colors.white,
    String image = 'default',
  }) {
    return Column(
      children: [
        CustomCircleAvater.getCircleAvatar(
          Image.asset(
            image,
            fit: BoxFit.cover,
            height: 40,
          ),
          radius,
          bgColor,
        ),
        CustomBoxes.getFittedBox(
          Text(
            text,
          ),
        ),
      ],
    );
  }
}
