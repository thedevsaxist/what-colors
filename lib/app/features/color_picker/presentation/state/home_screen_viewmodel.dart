import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatcolors/app/features/color_picker/data/services/color_extractor_service.dart';

abstract class IHomeScreenViewmodel extends ChangeNotifier {
  File? get image;
  ImagePicker get picker;
  List<Color> get colors;

  Future<void> pickImage();
}

class HomeScreenViewmodel extends ChangeNotifier implements IHomeScreenViewmodel {
  final IColorExtractorService colorExtractorService;

  HomeScreenViewmodel({required this.colorExtractorService});

  final _picker = ImagePicker();
  File? _image;
  List<Color>? _colors;

  @override
  File? get image => _image;

  @override
  ImagePicker get picker => _picker;

  @override
  List<Color> get colors => _colors!;

  @override
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _image = File(image.path);
      notifyListeners();

      _extractColors();
    }
  }

  Future<void> _extractColors() async {
    _colors = await colorExtractorService.extractDominantColors(_image!, maxColors: 10);
    notifyListeners();
  }
}
