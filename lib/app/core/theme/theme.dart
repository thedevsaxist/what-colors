import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(brightness: Brightness.dark);

  ThemeMode _currentThemeMode = ThemeMode.dark;

  ThemeMode get currentThemeMode => _currentThemeMode;

  bool get isDarkMode => _currentThemeMode == ThemeMode.dark;

  void toggleTheme() {
    _currentThemeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
