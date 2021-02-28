import 'package:flutter/material.dart';
import 'package:gelir_gider/widgets/year_page/day_item.dart';
import 'package:gelir_gider/generated/l10n.dart';

class DayListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weekList = <String>[
      S.of(context).Monday,
      S.of(context).Tuesday,
      S.of(context).Wednesday,
      S.of(context).Thursday,
      S.of(context).Friday,
      S.of(context).Saturday,
      S.of(context).Sunday
    ];

    var weekButtons = [
      DayListItem(title: weekList[0]),
      DayListItem(title: weekList[1]),
      DayListItem(title: weekList[2]),
      DayListItem(title: weekList[3]),
      DayListItem(title: weekList[4]),
      DayListItem(title: weekList[5]),
      DayListItem(title: weekList[6]),
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
