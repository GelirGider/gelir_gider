import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:gelir_gider/themes/colours.dart';

class ThemeDialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    return SimpleDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.all( Radius.circular(20.0)),
      ),
      titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      title: Text(
        S.of(context).ThemeSelectionQuestion,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, height: 2.5,
        letterSpacing: 1.0),
      ),
      children: <Widget>[
        Divider(
          color: Theme.of(context).textTheme.caption.color,
        ),
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          onPressed: () {
            _theme.setTheme(true);
            //Provider.of<CustomThemeModal>(context, listen: false)
            //    .setTheme('light');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _theme.getTheme() == _theme.dark
                  ? Icon(Icons.wb_sunny, color: Colours.white)
                  : Icon(Icons.wb_sunny_outlined, color: Colours.black),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
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
            _theme.setTheme(false);

            //Provider.of<CustomThemeModal>(context, listen: false)
            //    .setTheme('dark');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _theme.getTheme() == _theme.dark
                  ? Icon(Icons.wb_sunny_outlined, color: Colours.white)
                  : Icon(Icons.wb_sunny, color: Colours.black),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
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
