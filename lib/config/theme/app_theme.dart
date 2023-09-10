import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF28FFBF);

const List<Color> _colorList = [
  _customColor,
  Colors.black26,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor < _colorList.length,
            'Colors must b between 0 and ${_colorList.length}');

  ThemeData theme() {
    return ThemeData(
        useMaterial3: true, colorSchemeSeed: _colorList[selectedColor]);
    //brightness: Brightness.dark);
  }
}
