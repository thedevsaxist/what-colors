import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatcolors/app/core/util/color_format_enum.dart';
import 'package:whatcolors/app/core/util/convert_rgb32_to_rgb255.dart';
import 'package:whatcolors/app/core/util/rgb_to_hex_converter.dart';
import 'package:whatcolors/app/core/util/toast_notification.dart';

void copyToClipboard(Color color, BuildContext context, ColorFormat colorFormat) {
  final colorText = colorFormat == ColorFormat.rgb
      ? convertRGB32toRGB255(color)
      : rgbToHexConverter(color);

  Clipboard.setData(ClipboardData(text: colorText));

  showToastNotification(colorText, context);
}
