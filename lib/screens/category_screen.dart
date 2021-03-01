import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/themes/colours.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    var isDark = _theme.getTheme() == _theme.dark;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return SafeArea(
      child: Scaffold(
        appBar: GradientAppBar(
          gradient: LinearGradient(colors: Colours.getGradientColors(isDark)),
          centerTitle: true,
          title: Text(
            S.of(context).AddingScreenCategories,
            style: TextStyle(
                color: Theme.of(context).primaryTextTheme.caption.color,
                fontSize: 24 * textScaleFactor),
          ),
        ),
        body: Container(
          color: Colors.blueGrey,
          child: Card(
            color: _theme.getTheme() == _theme.dark
                ? Color(0xff333333)
                : Color.fromRGBO(254, 254, 254, 100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.fromLTRB(40, 70, 40, 95),
            borderOnForeground: true,
            semanticContainer: true,
            child: Consumer<Expenses>(
              builder: (context, provider, child) {
                final categories = provider.isPersonal
                    ? provider.categories
                    : provider.corporateCategories;
                print('length::::::::::::${categories.length}');
                return GridView.count(
                  padding: const EdgeInsets.all(15),
                  crossAxisCount: 3,
                  children: categories.map(
                    (element) {
                      return FittedBox(
                        child: FlatButton(
                          onPressed: () {
                            print('index::::::::${element.categoryName}');
                            provider.setCurrentCategory(element.index);
                            print(
                                'currentCategoryId::::::::${provider.currentCategoryId}');
                            return Navigator.pop(context, element.index);
                          },
                          child: element,
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
