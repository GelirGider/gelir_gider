import 'package:flutter/material.dart';

class CustomThemeModal with ChangeNotifier {
  ThemeData _themeData;
  CustomThemeModal(this._themeData);

  ThemeData get getThemeData => _themeData;

  void setThemeData(ThemeData data) {
    _themeData = data;
    notifyListeners();
  }
}