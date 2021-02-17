import 'package:flutter/material.dart';
import 'package:gelir_gider/widgets/category_item.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:gelir_gider/modals/custom_theme_modal.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  static var categories = <CategoryItem>[
    CategoryItem(Image.asset('assets/categories/dues.png'), 'Aidat', 0),
    CategoryItem(Image.asset('assets/categories/shopping.png'), 'Alışveriş', 1),
    CategoryItem(Image.asset('assets/categories/education.png'), 'Eğitim', 2),
    CategoryItem(
        Image.asset('assets/categories/entertainment.png'), 'Eğlence', 3),
    CategoryItem(Image.asset('assets/categories/hire.png'), 'Kira', 4),
    CategoryItem(
        Image.asset('assets/categories/selfcare.png'), 'Kişisel Bakım', 5),
    CategoryItem(Image.asset('assets/categories/bill.png'), 'Ödeme', 6),
    CategoryItem(Image.asset('assets/categories/health.png'), 'Sağlık', 7),
    CategoryItem(Image.asset('assets/categories/fix.png'), 'Tamir', 8),
    CategoryItem(Image.asset('assets/categories/holiday.png'), 'Tatil', 9),
    CategoryItem(Image.asset('assets/categories/food.png'), 'Yeme İçme', 10),
    CategoryItem(Image.asset('assets/categories/other.png'), 'Diğer', 11),
  ];

  @override
  Widget build(BuildContext context) {
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
            'Kategoriler',
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

  static CategoryItem getCategory(index) {
    return categories[index];
  }
}
