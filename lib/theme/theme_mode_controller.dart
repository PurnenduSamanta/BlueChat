import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeController extends ChangeNotifier {
  static const String _themeKey = 'is_dark_mode';
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> setThemeMode() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();

    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_themeKey, isDarkMode);
  }

  Future<void> loadThemeMode() async {
    final pref = await SharedPreferences.getInstance();
    final bool? stored = pref.getBool(_themeKey);
    final bool saved = stored != null ? stored : false;
    _themeMode = saved ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
