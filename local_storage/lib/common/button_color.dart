import 'package:flutter/material.dart';

class PrimaryButtonColor extends MaterialStateColor {
  const PrimaryButtonColor({required this.context}) : super(_defaultColor);
  final BuildContext context;
  static const int _defaultColor = 0xDB1887E8;
  static const int _pressedColor = 0xDE074EA5;
  static const int _hoveredColor = 0xDE549BF3;
  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    if (states.contains(MaterialState.hovered)) {
      return const Color(_hoveredColor);
    }

    return Theme.of(context).primaryColor;
  }
}
