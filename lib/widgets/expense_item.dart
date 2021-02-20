import 'dart:ui';
import 'package:jiffy/jiffy.dart';

import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/custom_theme_modal.dart';
import '../providers/expense_provider.dart';
import 'package:provider/provider.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({Key key, this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<CustomThemeModal>(context, listen: false);
    var provider = Provider.of<Expenses>(context);
    print('expense.category::::::::::::::::${expense.category}');
    print('expense.description::::::::::::::::${expense.description}');
    print('expense.id::::::::::::::::${expense.id}');

    return ListTile(
      leading: FittedBox(
        fit: BoxFit.cover,
        child: CircleAvatar(
          child: provider.imgList[expense.category],
          backgroundColor: Colors.white,
          radius: 25,
        ),
      ),
      title: Text(
        Jiffy(expense.time).format('dd-MM-yyyy') +
            '        ' +
            expense.description,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        provider.categories[expense.category].categoryName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: expense.isExpense == 'expense'
          ? Text(
              '- ₺ ' + expense.price.toString(),
              style: TextStyle(color: Colors.red, fontSize: 15),
            )
          : Text(
              '+ ₺ ' + expense.price.toString(),
              style: TextStyle(color: Colors.green, fontSize: 15),
            ),
    );
  }
}
