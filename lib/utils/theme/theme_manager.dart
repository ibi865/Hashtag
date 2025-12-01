import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  static const _themeKey = 'themeMode';
  ThemeData _themeData = ThemeData.light();
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeManager() {
    _loadTheme();
  }

  ThemeData get themeData => _themeData;

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? false;
    _themeData = isDarkMode ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }

  Future<void> setThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
    _isDarkMode = isDark;
    _themeData = isDark ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }

  void toggleTheme() {
    bool isDark = _themeData.brightness == Brightness.dark;
    setThemeMode(!isDark);
  }
}
