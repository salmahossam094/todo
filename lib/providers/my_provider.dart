import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/model/user_model.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';

class MyProvider extends ChangeNotifier {
  User? firebaseUser;
  UserModel? myUser;
  String language = 'en';
  ThemeMode theme = ThemeMode.light;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  Future<void> initUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    myUser = await FireBaseFunctions.readUser(firebaseUser!.uid);
    notifyListeners();
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  changeTheme(ThemeMode mode) async {
    theme = mode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mode', mode == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }

  changeLanguage(String lang) async {
    language = lang;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', lang);
    notifyListeners();
  }
}
