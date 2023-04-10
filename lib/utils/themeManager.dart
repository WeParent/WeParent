import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  final _prefsFuture = SharedPreferences.getInstance();
  ThemeMode _themeMode = ThemeMode.light;

  ThemeManager() {
    // Read the saved theme mode from shared preferences and update the current theme mode.
    _prefsFuture.then((prefs) {
      final isDarkMode = prefs.getBool('darkMode') ?? false;
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    });
  }

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    _prefsFuture.then((prefs) {
      prefs.setBool('darkMode', _themeMode == ThemeMode.dark);
    });
  }

  void activateDarkMode() {
    setThemeMode(_themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }
}
