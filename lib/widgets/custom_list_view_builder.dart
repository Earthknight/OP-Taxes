import 'package:flutter/material.dart';

class CustomListViewBuilder {
  static ListView getListViewBuilder(
    int itemCount,
    Widget Function(BuildContext, int) builderFunction, {
    Axis scrollAxis = Axis.vertical,
    bool reverse = false,
    EdgeInsetsGeometry? padding,
  }) {
    return ListView.builder(
      scrollDirection: scrollAxis,
      itemCount: itemCount,
      itemBuilder: builderFunction,
      reverse: reverse,
      padding: padding,
    );
  }
}
