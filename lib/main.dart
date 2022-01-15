import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxes/screens/drawer.dart';
import 'controllers/taxdef_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  final taxdefController = Get.put(TaxdefController());
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Taxes OP',
      home: DrawerScreen(),
    );
  }
}
