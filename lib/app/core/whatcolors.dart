import 'package:flutter/material.dart';
import 'package:whatcolors/app/core/theme/theme.dart';

class WhatColors extends StatelessWidget {
  const WhatColors({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What Colors?',
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
