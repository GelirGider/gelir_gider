import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/widgets/components/main_drawer.dart';
import 'expenses_list_screen.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:gelir_gider/providers/theme_provider.dart';

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
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      drawer: MainDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color: Colours.languageContainerBg,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: _theme.getTheme() == _theme.dark
              ? Color(0xff333333)
              : Color.fromRGBO(254, 254, 254, 100),
          margin: EdgeInsets.symmetric(vertical:135.0, horizontal: 30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  S.of(context).DrawerLanguageText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20*textScaleFactor,color: Colours.white, fontWeight: FontWeight.bold,letterSpacing: 0.8),
                ),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 16/9,
                    padding: EdgeInsets.all(10.0),
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
                SizedBox(
                  height: 25.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
