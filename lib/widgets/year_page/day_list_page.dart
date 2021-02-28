import 'package:flutter/material.dart';
import 'package:gelir_gider/widgets/year_page/day_item.dart';
import 'package:gelir_gider/generated/l10n.dart';

class DayListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dayList = <String>[
      S.of(context).Monday,
      S.of(context).Tuesday,
      S.of(context).Wednesday,
      S.of(context).Thursday,
      S.of(context).Friday,
      S.of(context).Saturday,
      S.of(context).Sunday
    ];

    var dayButtons = [
      DayListItem(title: dayList[0]),
      DayListItem(title: dayList[1]),
      DayListItem(title: dayList[2]),
      DayListItem(title: dayList[3]),
      DayListItem(title: dayList[4]),
      DayListItem(title: dayList[5]),
      DayListItem(title: dayList[6]),
    ];

    return GridView.count(
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20.0,
      padding: EdgeInsets.all(30.0),
      childAspectRatio: 7 / 5,
      crossAxisCount: 2,
      children: dayButtons,
    );
  }
}
