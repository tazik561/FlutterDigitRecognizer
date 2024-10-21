import 'package:flutter/material.dart';

import 'draw_screen_theme_data.dart';

class DrawScreenTheme extends InheritedWidget {
  final DrawScreenThemeData data;

  const DrawScreenTheme({
    super.key,
    required this.data,
    required super.child,
  });

  static DrawScreenThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<DrawScreenTheme>();
    return theme?.data ?? const DrawScreenThemeData();
  }

  @override
  bool updateShouldNotify(covariant DrawScreenTheme oldWidget) {
    return data != oldWidget.data;
  }
}
