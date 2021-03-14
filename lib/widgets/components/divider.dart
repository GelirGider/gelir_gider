import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:provider/provider.dart';

class OurDivider extends StatelessWidget {

  // Tekrarı önlemek adına programa has bir divider oluşturduk

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    var isDark = _theme.getTheme() == _theme.dark;
    return Divider(
      height: size.height*0.025,
      color: Colours.getBlackOrWhite(isDark),
    );
  }
}
