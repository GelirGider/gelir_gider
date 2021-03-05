import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/themes/colours.dart';


class CategoryItem extends StatelessWidget {

  // Ana ekranda karşımıza çıkan kategorilerin her biri için belirlediğimiz sabit dizayn

  final int index;
  final Image categoryImg;
  final String categoryName;

  const CategoryItem({Key key, this.index, this.categoryImg, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    var isDark = _theme.getTheme() == _theme.dark;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colours.getCategoryItemBg(isDark),
        border: Border.all(
          width: 5,
          color: Colours.getCategoryItemBorder(isDark),
        ),
      ),
      child: Column(
        children: [
          categoryImg,
          Text(categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 75*textScaleFactor,
                color: Colours.getBlackOrWhite(isDark),
              ))
        ],
      ),
    );
  }
}
