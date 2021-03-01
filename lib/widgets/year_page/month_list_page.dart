import 'package:flutter/material.dart';
import 'month_item.dart';
import 'package:gelir_gider/widgets/year_page/month_item.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/generated/l10n.dart';

class MonthListPage extends StatefulWidget {
  @override
  _MonthListPageState createState() => _MonthListPageState();
}

class _MonthListPageState extends State<MonthListPage> {
  @override
  Widget build(BuildContext context) {
    var expenseProvider = Provider.of<Expenses>(context);
    final monthList = expenseProvider.getCurrentMonths();

    final monthNames = <String>[
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

    var monthButtons = <MonthListItem>[];
    monthList.forEach((index) {
      monthButtons.add(
          MonthListItem(
            title: monthNames[index-1],
            index: (index-1),
          )
      );
    });

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
