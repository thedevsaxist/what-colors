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

      if (!context.mounted) return;
      showColorPalette(context);
    }
  }

  Future<void> _extractColors() async {
    _colors = await colorExtractorService.extractDominantColors(_image!);
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
        return DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.15,
          initialChildSize: 0.5,
          maxChildSize: 0.5,
          snap: true,
          shouldCloseOnMinExtent: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, top: 10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.cancel_rounded, size: 30),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: _colors!.length,
                    itemBuilder: (context, index) {
                      final color = _colors![index];
                      return ListTile(
                        onTap: () => _copyToClipboard(color, context),

                        title: Text(
                          "RGB: ${color.r.toStringAsFixed(4)}, ${color.g.toStringAsFixed(4)}, ${color.b.toStringAsFixed(4)}",
                        ),
                        trailing: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _copyToClipboard(Color color, BuildContext context) {
    final colorText =
        "RGB: ${color.r.toStringAsFixed(4)}, ${color.g.toStringAsFixed(4)}, ${color.b.toStringAsFixed(4)}";

    // print(color.b.);

    Clipboard.setData(ClipboardData(text: colorText));

    // TODO: replace this with a toast to show it from the top
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Copied this color: $colorText")));
  }
}
