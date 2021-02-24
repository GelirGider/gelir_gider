import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/widgets/main_drawer.dart';
import 'expenses_list_screen.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:provider/provider.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

List icons = [
  ClipRRect(
    child: Image.asset(
      'assets/flags/turkey.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    child: Image.asset(
      'assets/flags/uk.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    child: Image.asset(
      'assets/flags/china.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    child: Image.asset(
      'assets/flags/spain.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    child: Image.asset(
      'assets/flags/india.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    child: Image.asset(
      'assets/flags/arabia.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    child: Image.asset(
      'assets/flags/portugal.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    child: Image.asset(
      'assets/flags/russia.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    child: Image.asset(
      'assets/flags/japan.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    child: Image.asset(
      'assets/flags/germany.png',
      fit: BoxFit.cover,
    ),
  )
];

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final padding = const EdgeInsets.all(30.0);
    return Scaffold(
      backgroundColor: Colors.red,
      drawer: MainDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white60,
          margin: EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 50.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  S.of(context).DrawerLanguageText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: GridView.count(
                    padding: padding,
                    crossAxisCount: 2,
                    children: List.generate(
                      icons.length,
                      (index) {
                        return FlatButton(
                          onPressed: () {
                            Provider.of<Languages>(context, listen: false)
                                .setLanguage(index);
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (ctx) => ExpensesListScreen(),
                            ));
                          },
                          child: icons[index],
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  width: 270.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    color: Colors.greenAccent[400],
                    child: Text(
                      S.of(context).LanguageScreenContinue,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},

                    ///???
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
