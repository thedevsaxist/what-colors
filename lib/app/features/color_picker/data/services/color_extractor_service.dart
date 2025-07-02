import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

abstract class IColorExtractorService {
  Future<List<Color>> extractDominantColors(File imageFile, {int maxColors = 6});
}

class ColorExtractorService implements IColorExtractorService {
  @override
  Future<List<Color>> extractDominantColors(File imageFile, {int maxColors = 6}) async {
    final image = Image.file(imageFile);
    final completer = Completer<ui.Image>();

    image.image
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener((ImageInfo info, bool _) {
            completer.complete(info.image);
          }),
        );

    final uiImage = await completer.future;
    final palette = await PaletteGenerator.fromImage(uiImage, maximumColorCount: maxColors);

    return palette.colors.toList();
  }
}
