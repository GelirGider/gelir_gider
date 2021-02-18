import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/category_item.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/modals/custom_theme_modal.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<Expenses>(context).categories;
    final _theme = Provider.of<CustomThemeModal>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: GradientAppBar(
          gradient: LinearGradient(
              colors: _theme.getThemeData.brightness == Brightness.dark
                  ? [Color(0xff212121), Color(0xff212121)]
                  : [Colors.purple, Colors.pink]),
          centerTitle: true,
          title: Text(
            S.of(context).AddingScreenCategories,
            style: TextStyle(
                color: Theme.of(context).primaryTextTheme.caption.color,
                fontSize: 24),
          ),
        ),
        body: Container(
          child: Card(
            color: _theme.getThemeData.brightness == Brightness.dark
                ? Color(0xff333333)
                : Color.fromRGBO(254, 254, 254, 100),
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 45),
            borderOnForeground: true,
            semanticContainer: true,
            child: GridView.count(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
              crossAxisCount: 3,
              children: List.generate(categories.length, (index) {
                return FittedBox(
                  child: FlatButton(
                    onPressed: () {
                      return Navigator.pop(context, categories[index]);
                    },
                    child: categories[index],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
