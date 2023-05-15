import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider extends ChangeNotifier {
  String language = 'en';
  ThemeMode theme = ThemeMode.light;

  changeTheme(ThemeMode mode)  async {
    theme = mode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mode',mode==ThemeMode.light?'light':'dark');
    notifyListeners();
  }

  changeLanguage(String lang) async {
    language = lang;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', lang);
    notifyListeners();
  }
}
