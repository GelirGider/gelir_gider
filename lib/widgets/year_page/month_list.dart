import 'package:flutter/material.dart';
import 'month_list_item.dart';
import 'package:gelir_gider/widgets/year_page/month_list_item.dart';
import 'week_list.dart';
import 'package:gelir_gider/generated/l10n.dart';

class MonthList extends StatefulWidget {
  @override
  _MonthListState createState() => _MonthListState();
}

class _MonthListState extends State<MonthList> {
  @override
  Widget build(BuildContext context) {
    final monthList = <String>[
      S.of(context).January,
      S.of(context).February,
      S.of(context).March,
      S.of(context).April,
      S.of(context).May,
      S.of(context).June,
      S.of(context).July,
      S.of(context).August,
      S.of(context).September,
      S.of(context).October,
      S.of(context).November,
      S.of(context).December,
    ];

    var monthButtons = [
      MonthListItem(title: monthList[0]),
      MonthListItem(title: monthList[1]),
      MonthListItem(title: monthList[2]),
      MonthListItem(title: monthList[3]),
      MonthListItem(title: monthList[4]),
      MonthListItem(title: monthList[5]),
      MonthListItem(title: monthList[6]),
      MonthListItem(title: monthList[7]),
      MonthListItem(title: monthList[8]),
      MonthListItem(title: monthList[9]),
      MonthListItem(title: monthList[10]),
      MonthListItem(title: monthList[11]),
    ];

    return GridView.count(
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 1.0,
      padding: EdgeInsets.all(30.0),
      crossAxisCount: 3,
      children: monthButtons,
    );
  }
}
