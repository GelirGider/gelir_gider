import 'dart:math';

import 'package:flutter/material.dart';
import '../providers/expense_provider.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({Key key, this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
//      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      leading: CircleAvatar(
        child: Text(
          expense.price.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      title: Text(
        expense.description,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        expense.time.toString(),
      ),
    );
  }
}
