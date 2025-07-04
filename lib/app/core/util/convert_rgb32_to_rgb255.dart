import 'dart:ui';

String convertRGB32toRGB255(Color color) {
  return "RGB: ${(color.r * 255.0).round()}, ${(color.g * 255.0).round()}, ${(color.b * 255.0).round()}";
}
