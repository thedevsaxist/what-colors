import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatcolors/app/core/service_locator.dart';
import 'package:whatcolors/app/core/whatcolors.dart';
import 'package:whatcolors/app/features/color_picker/presentation/state/home_screen_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  serviceLocator();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => sl<IHomeScreenViewmodel>())],
      child: const WhatColors(),
    ),
  );
}
