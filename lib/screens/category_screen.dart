import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/themes/colours.dart';

class CategoryScreen extends StatelessWidget {
  final ScrollController _controllerOne = ScrollController();
  // Kategori seçim ekranının tasarımı ve tüm arkaplanının yapıldığı kısım

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    var isDark = _theme.getTheme() == _theme.dark;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colours.getGradientNew(isDark) //change your color here
              ),
          shape: Border(
              bottom: BorderSide(
                  width: textScaleFactor * 3.0,
                  color: Colours.getGradientNew(isDark))),
          backgroundColor: Colours.getGradientNew2(isDark),
          centerTitle: true,
          title: Text(
            S.of(context).AddingScreenCategories,
            style: TextStyle(
                color: Colours.getGradientNew(isDark),
                fontSize: 24 * textScaleFactor),
          ),
        ),
        body: Container(
          height: size.height,
          color: Colors.blueGrey,
          child: Card(
            color: _theme.getTheme() == _theme.dark
                ? Color(0xff333333)
                : Color.fromRGBO(254, 254, 254, 100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.symmetric(
                vertical: size.height * 0.0075, horizontal: size.width * 0.05),
            borderOnForeground: true,
            semanticContainer: true,
            child: Consumer<Expenses>(
              builder: (context, provider, child) {
                final categories = provider.isPersonal
                    ? provider.categories
                    : provider.corporateCategories;
                print('length::::::::::::${categories.length}');
                return Container(
                  child: Scrollbar(
                    thickness: 5,
                    radius: Radius.circular(15),
                    isAlwaysShown: true,
                    controller: _controllerOne,
                    child: GridView.count(
                      controller: _controllerOne,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children: categories.map(
                        (element) {
                          return FittedBox(
                            child: TextButton(
                              onPressed: () {
                                provider.setCurrentCategory(element.index);
                                return Navigator.pop(context, element.index);
                              },
                              child: element,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
