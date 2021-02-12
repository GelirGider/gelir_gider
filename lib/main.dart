import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:gelir_gider/screens/language_selection_screen.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/modals/custom_theme_modal.dart';
import 'package:gelir_gider/themes/lightTheme.dart';
import 'package:gelir_gider/themes/darkTheme.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LanguageHandler(),
        ),
        ChangeNotifierProvider.value(
          value: Expenses(),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomThemeModal(darkTheme),
        ),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('tr')],
      title: 'Gelir/Gider',
      theme: Provider.of<CustomThemeModal>(context).getThemeData,
      debugShowCheckedModeBanner: false,
      home: LanguageSelectionScreen(),
    );
  }
}
