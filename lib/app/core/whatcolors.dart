import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:whatcolors/app/core/theme/theme.dart';
import 'package:whatcolors/app/features/color_picker/presentation/screens/home_screen.dart';

class WhatColors extends StatelessWidget {
  const WhatColors({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<AppTheme>();
    return MaterialApp(
      builder: FToastBuilder(),
      // navigatorKey: ,
      debugShowCheckedModeBanner: false,
      title: 'What Colors?',
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeState.currentThemeMode,
      home: HomeScreen(),
    );
  }
}
