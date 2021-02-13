import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gelir_gider/modals/custom_theme_modal.dart';
import '../providers/expense_provider.dart';
import 'package:provider/provider.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({Key key, this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<CustomThemeModal>(context, listen: false);

    return ListTile(
      leading: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        decoration: BoxDecoration(
          border: Border.all(
            color: _theme.getThemeData.brightness == Brightness.dark
                ? Color.fromRGBO(1223, 81, 83, 1)
                : Colors.black,
          ),
        ),
        child: Text(expense.time),
      ),
      title: Text(expense.description, overflow: TextOverflow.ellipsis),
      subtitle: Text(expense.category),
      trailing: expense.isExpense == 'expense'
          ? Text(
              '+ ₺ ' + expense.price.toString(),
              style: TextStyle(color: Colors.green, fontSize: 15),
            )
          : Text(
              '- ₺ ' + expense.price.toString(),
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
    );
  }
}
