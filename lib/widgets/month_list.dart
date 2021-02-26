import 'package:flutter/material.dart';
import 'month_list_item.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/screens/expenses_list_screen.dart';
import 'package:gelir_gider/widgets/month_list_item.dart';
import 'week_list.dart';
import 'week_list_item.dart';


class MonthList extends StatefulWidget {
  @override
  _MonthListState createState() => _MonthListState();
}

class _MonthListState extends State<MonthList> {

  @override
  Widget build(BuildContext context) {
    final monthList = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    var monthButtons = [
      MonthListItem(title: monthList[0],),
      MonthListItem(title: monthList[1]),
      MonthListItem(title: monthList[2],),
      MonthListItem(title: monthList[3],),
      MonthListItem(title: monthList[4]),
      MonthListItem(title: monthList[5],),
      MonthListItem(title: monthList[6],),
      MonthListItem(title: monthList[7]),
      MonthListItem(title: monthList[8],),
      MonthListItem(title: monthList[9],),
      MonthListItem(title: monthList[10]),
      MonthListItem(title: monthList[11],),

    ];
    return Scaffold(
      body: GridView.count(
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1.0,
        padding: EdgeInsets.all(10.0),
        crossAxisCount: 3,
        children: List.generate(
          monthList.length,
              (index) {
            return FlatButton(
              onPressed: () {Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => WeekList(),
                ),
              );


              },
              child: Text(monthList[index]),
            );
          },
        ),
      ),
    );
  }
}
