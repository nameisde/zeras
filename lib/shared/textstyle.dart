import 'package:flutter/material.dart';

TextStyle styleSizeColorWeight(
    double size, Color color, FontWeight fontWeight) {
  return TextStyle(
      fontFamily: 'Poppins',
      color: color,
      fontSize: size,
      fontWeight: fontWeight);
}

TextStyle styleSizeColor(double fontSize, Color color) {
  return TextStyle(
    fontFamily: 'Poppins',
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: fontSize,
  );
}
