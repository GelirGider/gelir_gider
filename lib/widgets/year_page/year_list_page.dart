import 'package:flutter/material.dart';
import 'month_item.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/screens/expenses_list_screen.dart';
import 'package:gelir_gider/widgets/year_page/month_item.dart';
import 'package:gelir_gider/widgets/year_page/day_item.dart';
import 'package:gelir_gider/widgets/year_page/year_item.dart';
import 'month_list_page.dart';

class YearListPage extends StatelessWidget {
  static final yearList = [
    2019,
    2020,
    2021,
  ];

  final yearButtons = [
    YearListItem(year: yearList[0]),
    YearListItem(year: yearList[1]),
    YearListItem(year: yearList[2]),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20.0,
      childAspectRatio: 1.0,
      padding: EdgeInsets.all(30.0),
      crossAxisCount: 3,
      children: yearButtons,
    );
  }
}
