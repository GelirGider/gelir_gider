import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final int index;
  final Image categoryImg;
  final String categoryName;

  const CategoryItem({Key key, this.index, this.categoryImg, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: _theme.getTheme() == _theme.dark
            ? Color.fromRGBO(30, 30, 30, 100)
            : Colors.white,
        border: Border.all(
          width: 5,
          color: _theme.getTheme() == _theme.dark
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
                color: _theme.getTheme() == _theme.dark
                    ? Colors.white
                    : Colors.black,
              ))
        ],
      ),
    );
  }
}
