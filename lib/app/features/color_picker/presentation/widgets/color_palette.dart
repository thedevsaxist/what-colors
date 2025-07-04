import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatcolors/app/core/util/color_format_enum.dart';
import 'package:whatcolors/app/core/util/convert_rgb32_to_rgb255.dart';
import 'package:whatcolors/app/core/util/copy_to_clipboard.dart';
import 'package:whatcolors/app/core/util/rgb_to_hex_converter.dart';
import 'package:whatcolors/app/features/color_picker/presentation/state/home_screen_viewmodel.dart';

class ColorPalette extends StatefulWidget {
  const ColorPalette({super.key});

  @override
  State<ColorPalette> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  @override
  Widget build(BuildContext context) {
    final homeScreenViewmodel = context.read<IHomeScreenViewmodel>();
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
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(flex: 2),

                // color format picker
                DropdownButton(
                  value: homeScreenViewmodel.colorFormat,
                  items: [
                    DropdownMenuItem(value: ColorFormat.hex, child: Text('Hex')),
                    DropdownMenuItem(value: ColorFormat.rgb, child: Text("RGB")),
                  ],
                  onChanged: (format) {
                    setState(() {
                      homeScreenViewmodel.changeColorFormat = format!;
                    });

                    print(homeScreenViewmodel.colorFormat);
                  },
                ),
                Spacer(),

                // close button
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
              ],
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: homeScreenViewmodel.colors.length,
                itemBuilder: (context, index) {
                  final color = homeScreenViewmodel.colors[index];
                  return ListTile(
                    onTap: () => copyToClipboard(color, context, homeScreenViewmodel.colorFormat),

                    title: Text(
                      homeScreenViewmodel.colorFormat == ColorFormat.rgb
                          ? convertRGB32toRGB255(color)
                          : "HEX: ${rgbToHexConverter(color)}",
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
  }
}
