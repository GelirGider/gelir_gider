import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:gelir_gider/themes/lightTheme.dart';
import 'package:gelir_gider/themes/darkTheme.dart';

class ThemeProvider extends ChangeNotifier {

  // Temaların dinamik olarak değişmesini sağlayan providerımız
  // Dark ve Light tema olmak üzere 2 temamız bulunmakta

  static const themePrefKey = 'isLight';
  final ThemeData dark = darkTheme;
  final ThemeData light = lightTheme;
  ThemeData _selectedTheme;
  SharedPreferences prefs;

  ThemeProvider(bool isLight) {
    _selectedTheme = isLight ? light : dark;
  }

  ThemeData getTheme() => _selectedTheme;

  // _selectedTheme değişkenini kullanıcının tercihine göre değiştirmekteyiz

  Future<void> setTheme(bool isLight) async {
    prefs = await SharedPreferences.getInstance();
    if (isLight) {
      _selectedTheme = light;
      await prefs.setBool('isLight', true);
    }
    else {
      _selectedTheme = dark;
      await prefs.setBool('isLight', false);
    }
    notifyListeners();
  }

}
