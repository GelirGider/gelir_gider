import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gelir_gider/modals/custom_theme_modal.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/generated/l10n.dart';

class CategoryItem extends StatelessWidget {
  final int index;
  final Image categoryImg;
  final String categoryName;

  const CategoryItem({Key key, this.index, this.categoryImg, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<CustomThemeModal>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: _theme.getThemeData.brightness == Brightness.dark
            ? Color.fromRGBO(30, 30, 30, 100)
            : Colors.white,
        border: Border.all(
          width: 5,
          color: _theme.getThemeData.brightness == Brightness.dark
              ? Colors.grey
              : Colors.black,
        ),
      ),
      child: Column(
        children: [
          categoryImg,
          Text(categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 75,
                color: _theme.getThemeData.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ))
        ],
      ),
    );
  }
}
