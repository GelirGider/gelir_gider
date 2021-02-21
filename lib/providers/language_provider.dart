import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Languages extends ChangeNotifier{
  final BuildContext context;
  Languages(this.context);

  var languageList = [
    Locale('tr'),
    Locale('en'),
    Locale('de'),
    Locale('ar'),
    Locale('es'),
    Locale('zh'),
  ];

  void setLanguage(int index) {
    S.load(languageList[index]);
    _saveLanguage(index).then((value) => {});
  }

  Future<String> _saveLanguage(index) async{
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt('language',index);
    return 'Başarılı';
  }
}


