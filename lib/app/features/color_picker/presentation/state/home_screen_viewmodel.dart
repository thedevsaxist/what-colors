import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class IHomeScreenViewmodel extends ChangeNotifier {
  File? get image;
  ImagePicker get picker;

  Future<void> pickImage();
}

class HomeScreenViewmodel extends ChangeNotifier implements IHomeScreenViewmodel {
  final _picker = ImagePicker();
  File? _image;

  @override
  File? get image => _image;

  @override
  ImagePicker get picker => _picker;

  @override
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _image = File(image.path);
      notifyListeners();
    }
  }
}
