import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gelir_gider/modals/custom_theme_modal.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/generated/l10n.dart';

class CategoryItem extends StatelessWidget {
  int index;
  BuildContext context;
  Image categoryImg;
  String categoryName;
  var categoryList;
  var imgList;
  CategoryItem(this.context,this.index) {
    imgList = [
      Image.asset('assets/categories/dues.png'),
      Image.asset('assets/categories/shopping.png'),
      Image.asset('assets/categories/education.png'),
      Image.asset('assets/categories/entertainment.png'),
      Image.asset('assets/categories/hire.png'),
      Image.asset('assets/categories/selfcare.png'),
      Image.asset('assets/categories/bill.png'),
      Image.asset('assets/categories/health.png'),
      Image.asset('assets/categories/fix.png'),
      Image.asset('assets/categories/holiday.png'),
      Image.asset('assets/categories/food.png'),
      Image.asset('assets/categories/other.png'),
    ];
    categoryList = [
      S.of(context).CategoryDues,
      S.of(context).CategoryShopping,
      S.of(context).CategoryEducation,
      S.of(context).CategoryEntertainment,
      S.of(context).CategoryRent,
      S.of(context).CategorySelfcare,
      S.of(context).CategoryPayment,
      S.of(context).CategoryHealth,
      S.of(context).CategoryRepair,
      S.of(context).CategoryVacation,
      S.of(context).CategoryEatDrink,
      S.of(context).CategoryOthers,
    ];
    categoryName = categoryList[index];
    categoryImg = imgList[index];
  }

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
