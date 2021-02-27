import 'package:flutter/material.dart';
import 'package:gelir_gider/widgets/year_page/week_list_item.dart';

class WeekList extends StatefulWidget {
  @override
  _WeekListState createState() => _WeekListState();
}

class _WeekListState extends State<WeekList> {
  @override
  Widget build(BuildContext context) {
    final weekList = <String>[
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    var weekButtons = [
      WeekListItem(
        title: weekList[0],
      ),
      WeekListItem(
        title: weekList[1],
      ),
      WeekListItem(
        title: weekList[2],
      ),
      WeekListItem(
        title: weekList[3],
      ),
      WeekListItem(
        title: weekList[4],
      ),
      WeekListItem(
        title: weekList[5],
      ),
      WeekListItem(
        title: weekList[6],
      ),
    ];

    return GridView.count(
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20.0,
      padding: EdgeInsets.all(30.0),
      childAspectRatio: 7 / 5,
      crossAxisCount: 2,
      children: weekButtons,
    );
  }
}
