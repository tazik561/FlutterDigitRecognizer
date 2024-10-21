import 'package:flutter/material.dart';

class DrawScreenThemeData {
  final Color borderColor;
  final double borderWidth;
  final BoxDecoration? decoration;

  const DrawScreenThemeData({
    this.borderColor = Colors.black,
    this.borderWidth = 2.0,
    this.decoration
  });
}
