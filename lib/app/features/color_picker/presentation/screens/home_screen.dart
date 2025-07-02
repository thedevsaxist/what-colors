import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uicons/uicons.dart';
import 'package:whatcolors/app/features/color_picker/presentation/state/home_screen_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final viewmodel = context.read<IHomeScreenViewmodel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton.filled(
          onPressed: () {},
          icon: Icon(UIcons.solidRounded.menu_burger, color: Colors.white, size: 18),
        ),

        title: Text("WhatColors?", style: GoogleFonts.pacifico(fontWeight: FontWeight.w500)),
      ),

      body: Consumer<IHomeScreenViewmodel>(
        builder: (context, viewmodel, child) => Center(
          child: viewmodel.image != null
              ? Image.file(viewmodel.image!, fit: BoxFit.scaleDown)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(UIcons.regularRounded.gallery),
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
