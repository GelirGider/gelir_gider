import 'package:flutter/material.dart';
import 'week_list_item.dart';
import 'week_list.dart';
import 'month_list.dart';
import 'package:gelir_gider/widgets/month_list.dart';

class MonthListItem extends StatelessWidget {
  final String title ;

  const MonthListItem({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18),
      onTap: () {
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => WeekList(),
          ),
        );
      },
      title: Text(
          'January',
      ),
    );
  }
}
