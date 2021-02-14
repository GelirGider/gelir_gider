import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/modals/custom_theme_modal.dart';
import 'package:gelir_gider/themes/darkTheme.dart';
import 'package:gelir_gider/themes/lightTheme.dart';

class ThemeDialogWidget extends StatelessWidget {
  ThemeDialogWidget();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      title: Text(
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
          child: const Text('Aydınlık',
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
          child: const Text(
            'Karanlık',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
