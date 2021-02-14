import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:gelir_gider/widgets/button_with_flag.dart';
import 'package:provider/provider.dart';

import 'expenses_list_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlagButton(
                    isEnglish: true,
                    onPressed: () {
                      Provider.of<LanguageHandler>(context, listen: false)
                          .setEnglish();
                      return Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ExpensesListScreen(),
                        ),
                      );
                    },
                    key: ValueKey(1),
                  ),
                  SizedBox(height: 100),
                  FlagButton(
                    isEnglish: false,
                    onPressed: () {
                      Provider.of<LanguageHandler>(context, listen: false)
                          .setTurkish();
                      return Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ExpensesListScreen(),
                        ),
                      );
                    },
                    key: ValueKey(2),
                  ),
                ],
              ),
            ),
        );
  }
}
