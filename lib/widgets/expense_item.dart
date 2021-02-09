import 'package:flutter/material.dart';
import '../providers/expense_provider.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({Key key, this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(expense.description),
        subtitle: Text(expense.category),
        trailing: expense.isExpense
            ? Text("- ₺ " + expense.price.toString(),
                style: TextStyle(color: Colors.red, fontSize: 15))
            : Text("+ ₺ " + expense.price.toString(),
                style: TextStyle(color: Colors.green, fontSize: 15)),
        leading: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).accentColor)),
        ));
  }
}
