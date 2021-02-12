import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/modals/custom_theme_modal.dart';
import 'package:gelir_gider/themes/darkTheme.dart';
import 'package:gelir_gider/themes/lightTheme.dart';

class ThemeDialogWidget extends StatelessWidget {
  final bool isEnglish;
  ThemeDialogWidget(this.isEnglish);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      title: isEnglish
          ? const Text(
              'Select Theme',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          : const Text(
              'Tema Seçiniz',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
      children: <Widget>[
        Divider(
          color: Theme.of(context).textTheme.caption.color,
        ),
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          onPressed: () {
            Provider.of<CustomThemeModal>(context, listen: false)
                .setThemeData(lightTheme);
          },
          child: isEnglish
              ? const Text(
                  'Light',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                )
              : const Text(
                  'Aydınlık',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
        ),
        Divider(
          color: Theme.of(context).textTheme.caption.color,
        ),
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          onPressed: () {
            Provider.of<CustomThemeModal>(context, listen: false)
                .setThemeData(darkTheme);
          },
          child: isEnglish
              ? const Text(
                  'Dark',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                )
              : const Text(
                  'Karanlık',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
        ),
      ],
    );
  }
}
