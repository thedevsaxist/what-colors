import 'package:flutter/material.dart';
import 'package:whatcolors/app/core/theme/theme.dart';
import 'package:whatcolors/app/features/color_picker/presentation/screens/home_screen.dart';

class WhatColors extends StatelessWidget {
  const WhatColors({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'What Colors?',
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}
