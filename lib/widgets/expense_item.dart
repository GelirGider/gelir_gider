import 'dart:ui';
import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import '../providers/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gelir_gider/providers/language_provider.dart';

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

    checkLanguage(context);
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
        Jiffy(widget.expense.time).yMMMd,
        style: TextStyle(fontSize: 12),
      ),
      subtitle: Text(
        widget.expense.description,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: widget.expense.isExpense == 'expense'
          ? Text(
              widget.expense.price.toString() + ' ' + widget.currency,
              style: TextStyle(color: Colors.red, fontSize: 15),
            )
          : Text(
              '+ ' + widget.expense.price.toString() + ' ' + widget.currency,
              style: TextStyle(color: Colors.green, fontSize: 15),
            ),
    );
  }

  void checkLanguage(context) async {
    var prefs = await SharedPreferences.getInstance();
    var index = await prefs.getInt('language');
    var currentLanguage =
        Provider.of<Languages>(context, listen: false).languageList[index];
    print(currentLanguage.languageCode);
    await Jiffy.locale(currentLanguage.languageCode);
  }
}
