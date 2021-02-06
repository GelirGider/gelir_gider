import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:theme_manager/change_theme_widget.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void setAsSystemDefault() => ThemeManager.of(context)
      .setBrightnessPreference(BrightnessPreference.system);
  void setAsLight() => ThemeManager.of(context)
      .setBrightnessPreference(BrightnessPreference.light);
  void setAsDark() => ThemeManager.of(context)
      .setBrightnessPreference(BrightnessPreference.dark);
  void showThemePicker() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ThemePickerDialog(
          onSelectedTheme: (BrightnessPreference preference) {
            ThemeManager.of(context).setBrightnessPreference(preference);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final langState = Provider.of<LanguageHandler>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(langState.isEnglish ? "Add/Remove" : "Ekle/Çıkar"),
        actions: [
          FlatButton(
            onPressed: showThemePicker,
            child: Icon(Icons.color_lens),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
