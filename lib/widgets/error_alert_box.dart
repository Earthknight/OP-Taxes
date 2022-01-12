import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorAlertBox {
  static Future<void> getErrorAlertBox(String errorMessage) {
    return Get.defaultDialog(
      title: 'An error occured!',
      middleText: errorMessage,
      textConfirm: 'Okay',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
      buttonColor: Colors.red,
      radius: 20,
    );
  }
}
