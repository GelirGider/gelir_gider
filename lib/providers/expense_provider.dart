import 'package:flutter/material.dart';

class Expense {
  final String description;
  final int price;
  final DateTime time;
  final String isExpense;

  Expense({this.description, this.price, this.time, this.isExpense});
}

class Expenses with ChangeNotifier {
  List<Expense> _expense = [];
  List<Expense> get expense {
    return [..._expense];
  }

  void addExpense(Expense expense) {
    _expense.add(expense);
    notifyListeners();
  }
}
