import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/custom_theme_modal.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/screens/expenses_list_screen.dart';
import 'package:gelir_gider/themes/lightTheme.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Expenses(),
          ),
          ChangeNotifierProvider(
            create: (context) => CustomThemeModal(lightTheme),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.purple,
      localizationsDelegates: [
        // 1
        S.delegate,
        // 2
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Gelir/Gider',
      theme: Provider.of<CustomThemeModal>(context).getThemeData,
      debugShowCheckedModeBanner: false,
      home: ExpensesListScreen(),
    );
  }
}
