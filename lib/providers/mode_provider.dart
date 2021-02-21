import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModeProvider extends ChangeNotifier {
  static const modePrefKey = 'isIndividual';

  ModeProvider();

  Future<bool> getMode() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(modePrefKey) ?? true;
  }

  Future<void> setMode(isIndividual) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(modePrefKey, isIndividual);
  }
}

///var isIndividual;
///final _mode = Provider.of<ModeProvider>(context, listen: false);
///_mode.getMode().then((value) => isIndividual =(value);
///_mode.setMode(false);
///_mode.getMode().then((value) => print(value));
