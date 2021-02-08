import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LanguageHandler with ChangeNotifier {
  bool isEnglish = true;

  void setEnglish() {
    isEnglish = true;
    notifyListeners();
  }

  void setTurkish() {
    isEnglish = false;
    notifyListeners();
  }
}
