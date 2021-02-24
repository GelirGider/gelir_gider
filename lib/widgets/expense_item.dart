import 'dart:ui';
import 'package:jiffy/jiffy.dart';

import 'package:flutter/material.dart';
import '../providers/expense_provider.dart';
import 'package:provider/provider.dart';

class ExpenseItem extends StatefulWidget {
  final Expense expense;
  const ExpenseItem({Key key, this.expense}) : super(key: key);

  @override
  _ExpenseItemState createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Expenses>(context, listen: false);
    var currency;
    provider.getCurrency().then((value) => currency = value);

    return ListTile(
      leading: FittedBox(
        fit: BoxFit.cover,
        child: CircleAvatar(
          child: provider.imgList[widget.expense.category],
          backgroundColor: Colors.white,
          radius: 25,
        ),
      ),
      title: Text(
        Jiffy(widget.expense.time).format('dd-MM-yyyy') +
            '        ' +
            widget.expense.description,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        provider.categories[widget.expense.category].categoryName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: widget.expense.isExpense == 'expense'
          ? Text(
              '- ' + widget.expense.price.toString() + ' ' + currency,
              style: TextStyle(color: Colors.red, fontSize: 15),
            )
          : Text(
              '+ ' + widget.expense.price.toString() + ' ' + currency,
              style: TextStyle(color: Colors.green, fontSize: 15),
            ),
    );
  }
}
