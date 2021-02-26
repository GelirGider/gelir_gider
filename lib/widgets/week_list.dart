import 'package:flutter/material.dart';
import 'month_list_item.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/screens/expenses_list_screen.dart';
import 'package:gelir_gider/widgets/week_list_item.dart';
import 'month_list.dart';

class WeekList extends StatefulWidget {
  @override
  _WeekListState createState() => _WeekListState();
}

class _WeekListState extends State<WeekList> {
  @override
  Widget build(BuildContext context) {

    final weekList = <String> [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    var weekButtons = [
      WeekListItem(title: weekList[0],),
      WeekListItem(title: weekList[1],),
      WeekListItem(title: weekList[2],),
      WeekListItem(title: weekList[3],),
      WeekListItem(title: weekList[4],),
      WeekListItem(title: weekList[5],),
      WeekListItem(title: weekList[6],),
    ];

    return Scaffold(
      body: GridView.count(
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1.0,
        padding: EdgeInsets.all(10.0),
        crossAxisCount: 3,
        children: List.generate(
          weekList.length,
              (index) {
            return FlatButton(
              onPressed: () {

              },
              child: Text(weekList[index]),
            );
          },
        ),
      ),
    );
  }
}
