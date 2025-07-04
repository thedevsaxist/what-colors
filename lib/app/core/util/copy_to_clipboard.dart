import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatcolors/app/core/util/color_format_enum.dart';
import 'package:whatcolors/app/core/util/convert_rgb32_to_rgb255.dart';
import 'package:whatcolors/app/core/util/rgb_to_hex_converter.dart';

void copyToClipboard(Color color, BuildContext context, ColorFormat colorFormat) {
  final colorText = colorFormat == ColorFormat.rgb
      ? convertRGB32toRGB255(color)
      : rgbToHexConverter(color);

  Clipboard.setData(ClipboardData(text: colorText));

  // TODO: replace this with a toast to show it from the top
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text("Copied this color: $colorText")));
}
