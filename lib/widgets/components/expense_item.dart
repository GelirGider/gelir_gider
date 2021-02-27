import 'dart:ui';
import 'package:flutter/material.dart';
import '../../providers/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatefulWidget {
  final Expense expense;
  final String currency;
  const ExpenseItem({Key key, this.expense, this.currency}) : super(key: key);

  @override
  _ExpenseItemState createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Expenses>(context, listen: false);
    //provider.getCurrency().then((value) => currency = value);
    return ListTile(
      leading: FittedBox(
        fit: BoxFit.cover,
        child: CircleAvatar(
          child: provider.imgList[widget.expense.category],
          backgroundColor: Colours.white,
          radius: 25,
        ),
      ),
      title: Text(
          DateFormat.yMMMd().format(DateTime.parse(widget.expense.time)),
        style: TextStyle(fontSize: 12),
      ),
      subtitle: Text(
        widget.expense.description,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: widget.expense.isExpense == 'expense'
          ? Text(
              widget.expense.price.toString() + ' ' + widget.currency,
              style: TextStyle(color: Colours.red, fontSize: 15),
            )
          : Text(
              '+ ' + widget.expense.price.toString() + ' ' + widget.currency,
              style: TextStyle(color: Colours.green, fontSize: 15),
            ),
    );
  }
}
