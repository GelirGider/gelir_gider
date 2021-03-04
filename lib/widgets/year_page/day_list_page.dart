import 'package:flutter/material.dart';
import 'package:gelir_gider/widgets/year_page/day_item.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/expense_provider.dart';

class DayListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var expenseProvider = Provider.of<Expenses>(context);
    var daysAndMonth = expenseProvider.selectedWeek;
    var days = daysAndMonth.split(' ')[0];
    var startDay = int.parse(days.split('-')[0]);
    var endDay = int.parse(days.split('-')[1]);
    var monthName = daysAndMonth.split(' ')[1];
    var dayButtons = <DayListItem>[];

    var curDays = expenseProvider.currentItems;

    curDays.keys.forEach((element) {
      if (element != null) {
        dayButtons.add(DayListItem(
          title: element.toString() + ' ' + monthName,
        ));
      }
    });

    return dayButtons.isEmpty
        ? Container()
        : Flexible(
            child: GridView.count(
              shrinkWrap: true,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              padding: EdgeInsets.all(30.0),
              childAspectRatio: 2.75,
              crossAxisCount: 1,
              children: dayButtons,
            ),
          );
  }
}
