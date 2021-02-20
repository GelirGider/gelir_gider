import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/custom_theme_modal.dart';
import 'package:gelir_gider/themes/darkTheme.dart';
import 'package:gelir_gider/themes/lightTheme.dart';

class ThemeDialogWidget extends StatelessWidget {
  ThemeDialogWidget();

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<CustomThemeModal>(context, listen: false);
    return SimpleDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      title: Text(
        S.of(context).ThemeSelectionQuestion,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, height: 2.5),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _theme.getThemeData.brightness == Brightness.dark
                  ? Icon(Icons.wb_sunny, color: Colors.white)
                  : Icon(Icons.wb_sunny_outlined, color: Colors.black),
              SizedBox(
                width: 25,
              ),
              Text(S.of(context).ThemeSelectionOption1,
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
            ],
          ),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _theme.getThemeData.brightness == Brightness.dark
                  ? Icon(Icons.wb_sunny_outlined, color: Colors.white)
                  : Icon(Icons.wb_sunny, color: Colors.black),
              SizedBox(
                width: 25,
              ),
              Text(
                S.of(context).ThemeSelectionOption2,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
