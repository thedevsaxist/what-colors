import 'package:flutter/material.dart';

String rgbToHexConverter(Color rgbColor) {
  String hexColors = "";

  final r = (rgbColor.r * 255.0).round().toRadixString(16).toUpperCase();
  final g = (rgbColor.g * 255.0).round().toRadixString(16).toUpperCase();
  final b = (rgbColor.b * 255.0).round().toRadixString(16).toUpperCase();

  hexColors = "#FF$r$g$b";

  return hexColors;
}
