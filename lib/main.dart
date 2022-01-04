import 'package:flutter/material.dart';
import 'package:taxes/screens/drawer.dart';
import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxes OP',
      home: DrawerScreen(),
    );
  }
}
