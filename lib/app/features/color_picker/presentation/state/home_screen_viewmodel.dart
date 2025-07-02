import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatcolors/app/features/color_picker/data/services/color_extractor_service.dart';

abstract class IHomeScreenViewmodel extends ChangeNotifier {
  File? get image;
  ImagePicker get picker;
  List<Color> get colors;

  Future<void> pickImage(BuildContext context);
  void showColorPalette(BuildContext context);
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
  Future<void> pickImage(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _image = File(image.path);
      notifyListeners();

      await _extractColors();
      showColorPalette(context);
    }
  }

  Future<void> _extractColors() async {
    _colors = await colorExtractorService.extractDominantColors(_image!, maxColors: 10);
    notifyListeners();
  }

  @override
  void showColorPalette(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isDismissible: false,
      constraints: BoxConstraints(minHeight: 200),
      builder: (context) {
        return ListView.builder(
          itemCount: _colors!.length,
          itemBuilder: (context, index) {
            final color = _colors![index];
            return GestureDetector(
              onTap: () => _copyToClipboard(color, context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "RGB: ${color.r.toStringAsFixed(4)}, ${color.g.toStringAsFixed(4)}, ${color.b.toStringAsFixed(4)}",
                    ),
                    Container(height: 15, width: 15, color: color),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _copyToClipboard(Color color, BuildContext context) {
    final colorText =
        "RGB: ${color.r.toStringAsFixed(4)}, ${color.g.toStringAsFixed(4)}, ${color.b.toStringAsFixed(4)}";

    Clipboard.setData(ClipboardData(text: colorText));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Copied this color: $colorText")));
  }
}
