import 'package:flutter/material.dart';
import 'month_list.dart';
import 'month_list_item.dart';
import 'year_list.dart';

class YearListItem extends StatelessWidget {

  final String title;
  const YearListItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => MonthListItem(),
          ),
        );
      },
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
