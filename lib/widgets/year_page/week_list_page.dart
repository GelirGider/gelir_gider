import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/widgets/year_page/week_item.dart';

class WeekListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var expenseProvider = Provider.of<Expenses>(context);
    var curMonth = expenseProvider.selectedMonth;
    final lastDay = expenseProvider.getLastDayOfMonth();

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

    var weekDays=[
      '1-7',
      '8-14',
      '15-21',
      '22-'+lastDay.toString()
    ];

    var weekButtons = <WeekItem>[];
    weekDays.forEach((weekText) {
      var startDay = int.parse(weekText.split('-')[0]);
      var endDay = int.parse(weekText.split('-')[1]);
      if(!expenseProvider.checkWeekNull(startDay,endDay)){
        weekButtons.add(WeekItem(
          title: weekText+ ' ' +monthNames[curMonth],
        ));
      }
    });

    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 1.5,
      padding: EdgeInsets.all(30.0),
      crossAxisCount: 2,
      children: weekButtons,
    );
  }
}
