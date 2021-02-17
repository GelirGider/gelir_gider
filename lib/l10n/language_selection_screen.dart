import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/screens/expenses_list_screen.dart';


class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

List flags = [
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
      body: Card(
          color: Colors.white60,
          margin: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                  child : GridView.count(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      children: List.generate(
                        flags.length,
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
                              child: flags[index],
                            ),
                          );
                        },
                      ),
                    ),
                  )],
          ),
            )
    );
  }
}