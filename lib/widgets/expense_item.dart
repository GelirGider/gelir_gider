import 'dart:ui';
import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import '../providers/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gelir_gider/providers/language_provider.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({Key key, this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkLanguage(context);
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
        Jiffy(expense.time).yMMMd,
        style: TextStyle(fontSize: 12),
      ),
      subtitle: Text(
        expense.description,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: expense.isExpense == 'expense'
          ? Text(
              expense.price.toString() + ' ₺',
              style: TextStyle(color: Colors.red, fontSize: 15),
            )
          : Text(
              '+ ' + expense.price.toString() + ' ₺',
              style: TextStyle(color: Colors.green, fontSize: 15),
            ),
    );
  }
  void checkLanguage(context) async{
    var prefs = await SharedPreferences.getInstance();
    var index = await prefs.getInt('language');
    var currentLanguage = Provider.of<Languages>(context,listen: false).languageList[index];
    print(currentLanguage.languageCode);
    await Jiffy.locale(currentLanguage.languageCode);
    }
  }
