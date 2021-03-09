import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Languages extends ChangeNotifier{

  // Dillerin cihaz hafızasında set edilmesi için yapmış olduğumuz provider

  var languageList = [
    Locale('tr'),
    Locale('en'),
    Locale('zh'),
    Locale('es'),
    Locale('hi'),
    Locale('ar'),
    Locale('pt'),
    Locale('ru'),
    Locale('ja'),
    Locale('de'),
  ];

  // Bu iki metotta seçilen dilin çağrılması ve
  // cihaz hafızasına kaydedilmesi işlemleri yapılmakta

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


