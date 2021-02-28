import 'package:flutter/material.dart';
import 'package:gelir_gider/widgets/year_page/week_item.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'week_item.dart';

class WeekListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weekList = <String> [
      'First Week',
      'Second Week',
      'Third Week',
      'Fourth Week'

    ];

    var weekButtons = [
      WeekListItem(title: weekList[0],index:0),
      WeekListItem(title: weekList[1],index:1),
      WeekListItem(title: weekList[2],index:2),
      WeekListItem(title: weekList[3],index:3),

    ];
    return GridView.count(
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 1.0,
      padding: EdgeInsets.all(30.0),
      crossAxisCount: 3,
      children: weekButtons,
    );
  }
}
