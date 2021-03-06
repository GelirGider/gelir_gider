import 'dart:ui';
import 'package:flutter/material.dart';
import '../../providers/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatefulWidget {

  // Ana ekranda tıkladığımız her bir kategorinin içerisinde bulunan harcamaların
  // gösterimi için yaptığımız sabit bir item design

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
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return ListTile(
      leading: FittedBox(
        fit: BoxFit.cover,
        child: CircleAvatar(
          child: provider.isPersonal
              ? provider.imgList[widget.expense.category]
              : provider.imgListCorporate[widget.expense.category],
          backgroundColor: Colours.white,
          radius: 25,
        ),
      ),
      title: Text(
        DateFormat.yMMMd().format(DateTime.parse(widget.expense.time)),
        style: TextStyle(fontSize: 12 * textScaleFactor),
      ),
      subtitle: Text(
        widget.expense.description,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: widget.expense.isExpense == 'expense'
          ? Text(
              widget.expense.price.toString() + ' ' + widget.currency,
              style:
                  TextStyle(color: Colours.red, fontSize: 15 * textScaleFactor),
            )
          : Text(
              '+ ' + widget.expense.price.toString() + ' ' + widget.currency,
              style: TextStyle(
                  color: Colours.green, fontSize: 15 * textScaleFactor),
            ),
    );
  }
}
