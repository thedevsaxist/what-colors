import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uicons/uicons.dart';
import 'package:whatcolors/app/core/theme/theme.dart';
import 'package:whatcolors/app/features/color_picker/presentation/state/home_screen_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    FToast().init(context);
  }
  @override
  Widget build(BuildContext context) {
    final viewmodel = context.read<IHomeScreenViewmodel>();
    final themeState = context.watch<AppTheme>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => themeState.toggleTheme(),
          icon: Icon(
            themeState.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            size: 32,
          ),
        ),
        title: Text(
          "WhatColors?",
          style: GoogleFonts.pacifico(
            fontWeight: FontWeight.w500,
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        centerTitle: true,
      ),

      // drawer: Drawer(
      //   child: SafeArea(
      //     child: Column(
      //       children: [
      //         DrawerHeader(child: Text("History")),
      //         IconButton(
      //           onPressed: () => themeState.toggleTheme(),
      //           icon: Icon(
      //             themeState.isDarkMode ? Icons.light_mode : Icons.dark_mode,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Consumer<IHomeScreenViewmodel>(
        builder: (context, viewmodel, child) => Center(
          child: viewmodel.image != null
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: Image.file(
                        viewmodel.image!,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(UIcons.regularRounded.picture, size: 40),
                    const SizedBox(height: 10),
                    Text("Add an image to extract colors"),
                  ],
                ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => viewmodel.pickImage(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
