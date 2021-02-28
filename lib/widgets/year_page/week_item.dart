import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:provider/provider.dart';
import 'day_list_page.dart';

class WeekListItem extends StatelessWidget {
  final String title;
  final int index;

  const WeekListItem({Key key, this.title, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<Expenses>(context, listen: false);
    return FlatButton(
      onPressed: () {
        expenseProvider.setSelectedWeek(index);
        expenseProvider.setSelectedPage(3);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: Colours.pink,
      child: Text(
        title,
        style: TextStyle(
          color: Colours.white,
        ),
      ),
    );
  }
}
