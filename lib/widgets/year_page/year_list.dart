import 'package:flutter/material.dart';
import 'month_list_item.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/screens/expenses_list_screen.dart';
import 'package:gelir_gider/widgets/year_page/month_list_item.dart';
import 'package:gelir_gider/widgets/year_page/week_list_item.dart';
import 'package:gelir_gider/widgets/year_page/year_list_item.dart';
import 'month_list.dart';

class YearList extends StatefulWidget {
  @override
  _YearListState createState() => _YearListState();
}

class _YearListState extends State<YearList> {
  @override
  Widget build(BuildContext context) {
    final yearList = <String>[
      '2019',
      '2020',
      '2021',
    ];

    var yearButtons = [
      YearListItem(title: yearList[0]),
      YearListItem(title: yearList[1]),
      YearListItem(title: yearList[2]),
    ];
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
