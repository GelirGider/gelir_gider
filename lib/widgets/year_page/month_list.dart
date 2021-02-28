import 'package:flutter/material.dart';
import 'month_list_item.dart';
import 'package:gelir_gider/widgets/year_page/month_list_item.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:provider/provider.dart';

class MonthList extends StatefulWidget {
  final year;
  MonthList(this.year);

  @override
  _MonthListState createState() => _MonthListState();


}

class _MonthListState extends State<MonthList> {
  @override
  Widget build(BuildContext context) {
    var expenseProvider = Provider.of<Expenses>(context);
    final monthList = expenseProvider.getCurrentMonths(widget.year); // (7,8,9,12)

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
            title: monthNames[index],
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
