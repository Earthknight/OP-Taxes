import 'package:flutter/material.dart';

// CLASS FOR COMMON CODE
class CommonCode {
  // STATIC METHOD TO RETURN THE SIZE OF DEVICE
  static Size getDeviceSize(BuildContext ctx) {
    return MediaQuery.of(ctx).size;
  }

  // STATIC METHOD TO SET THE MARGIN OR PADDING USING EDGEINSETS
  static EdgeInsetsGeometry setEgdeInsetsSymmteric(
    double horizontal,
    double vertical,
  ) {
    return EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: vertical,
    );
  }

  static const CREATE_TABLE = 'CREATE TABLE';
  static const CATEGORY_TABLE =
      '(id TEXT PRIMARY KEY, FOREIGN KEY (id) REFERENCES taxes(id))';
  static const INSERT_INTO = 'INSERT INTO';
  static const MOSTLY_SEARCHED_TABLE = 'mostly_searched_taxes';
  static const MOSTLY_APPEARED_TABLE = 'mostly_appeared_taxes';
  static const MOSTLY_KNOWN_TABLE = 'mostly_known_taxes';
}
