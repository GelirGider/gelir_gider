import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/widgets/components/main_drawer.dart';
import 'expenses_list_screen.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:gelir_gider/providers/theme_provider.dart';

// Drawer da bulunan Dil seçim ekranının tasarımı ve tüm arkaplanının bulunduğu
// kısım

class LanguageSelectionScreen extends StatefulWidget {

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {

  List<String> assets = [
    'assets/flags/turkey.png',
    'assets/flags/uk.png',
    'assets/flags/china.png',
    'assets/flags/spain.png',
    'assets/flags/india.png',
    'assets/flags/arabia.png',
    'assets/flags/portugal.png',
    'assets/flags/russia.png',
    'assets/flags/japan.png',
    'assets/flags/germany.png',
  ];
  List<ClipRRect> icons = [];

  @override
  void initState() {
    super.initState();
    assets.forEach((asset) => icons.add(
      ClipRRect(
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
        ),
      ),));
  }

  @override
  Widget build(BuildContext context) {

    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final size = MediaQuery.of(context).size;

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
          margin: EdgeInsets.symmetric(vertical:size.height*0.12, horizontal: size.width*0.1),
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
                    padding: EdgeInsets.all(0.010*size.height),
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
                  height: 0.025*size.height,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
