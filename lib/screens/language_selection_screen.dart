import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';

import 'expenses_list_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

List icons = [
  Image.asset('assets/flags/turkey.png'),
  Image.asset('assets/flags/usa.png'),
  Image.asset('assets/flags/germany.png'),
  Image.asset('assets/flags/arabia.png'),
  Image.asset('assets/flags/spain.png'),
  Image.asset('assets/flags/china.png'),
];

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.white60,
          margin: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Dil/Language',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(
                      icons.length,
                      (index) {
                        return FittedBox(
                          child: FlatButton(
                            onPressed: () {
                              if (index == 0) {
                                S.load(Locale('tr'));
                              }
                              if (index == 1) {
                                S.load(Locale('en'));
                              }
                              return Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => ExpensesListScreen(),
                                ),
                              );
                            },
                            child: icons[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
