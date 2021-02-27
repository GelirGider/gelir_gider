import 'package:flutter/material.dart';
import 'month_list.dart';
import 'month_list_item.dart';
import 'week_list.dart';

class WeekListItem extends StatelessWidget {

  final String title;
  const WeekListItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: Colors.pink,
      child: Text(
        'Sunday',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
