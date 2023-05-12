import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  String language = 'en';
  ThemeMode theme = ThemeMode.light;

  changeTheme(ThemeMode mode) {
    theme = mode;
    notifyListeners();
  }

  changeLanguage(String lang) {
    language = lang;
    notifyListeners();
  }
}
