import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:gelir_gider/themes/colours.dart';


class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    var isDark = _theme.getTheme() == _theme.dark;

    return Container(
      width: MediaQuery.of(context).size.height * 0.1,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Icon(
        Icons.add,
        size: MediaQuery.of(context).size.height * 0.06,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: Colours.getGradientColors(isDark)),
      ),
    );
  }
}
