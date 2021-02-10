import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:theme_manager/theme_manager.dart';
import '../providers/expense_provider.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({Key key, this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(expense.time);
    return ListTile(
      title: Text(
        expense.description,
        style: TextStyle(
          color: ThemeManager.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      //subtitle: Text(expense.category),
      trailing: expense.isExpense == 'expense'
          ? Text(
              "- ₺ " + expense.price.toString(),
              style: TextStyle(color: Colors.red, fontSize: 15),
            )
          : Text(
              "+ ₺ " + expense.price.toString(),
              style: TextStyle(color: Colors.green, fontSize: 15),
            ),
      leading: Container(
        width: 150,
        height: 100,
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).accentColor,
          ),
        ),
        child: Text(
          expense.time,
          style: TextStyle(
            color: ThemeManager.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
