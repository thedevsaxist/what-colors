import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatcolors/app/core/util/color_format_enum.dart';
import 'package:whatcolors/app/features/color_picker/data/services/color_extractor_service.dart';
import 'package:whatcolors/app/features/color_picker/presentation/widgets/color_palette.dart';

abstract class IHomeScreenViewmodel extends ChangeNotifier {
  File? get image;
  ImagePicker get picker;
  List<Color> get colors;

  ColorFormat get colorFormat;
  set changeColorFormat(ColorFormat color);

  Future<void> pickImage(BuildContext context);
  void showColorPalette(BuildContext context);
}

class HomeScreenViewmodel extends ChangeNotifier implements IHomeScreenViewmodel {
  final IColorExtractorService colorExtractorService;

  HomeScreenViewmodel({required this.colorExtractorService});

  final _picker = ImagePicker();
  File? _image;
  List<Color>? _colors;
  ColorFormat _colorFormat = ColorFormat.hex;

  @override
  File? get image => _image;

  @override
  ImagePicker get picker => _picker;

  @override
  List<Color> get colors => _colors!;

  @override
  ColorFormat get colorFormat => _colorFormat;

  @override
  set changeColorFormat(ColorFormat color) {
    _colorFormat = color;
  }

  @override
  Future<void> pickImage(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _image = File(image.path);
      notifyListeners();

      await _extractColors();

      if (!context.mounted) return;
      showColorPalette(context);
    }
  }

  Future<void> _extractColors() async {
    _colors = await colorExtractorService.extractDominantColors(_image!, maxColors: 12);
    notifyListeners();
  }

  @override
  void showColorPalette(BuildContext context) {
    showModalBottomSheet(
      // barrierColor: MediaQuery.sizeOf(context).height * 0.15 ? Colors.transparent,
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      builder: (context) {
        return ColorPalette();
      },
    );
  }
}
