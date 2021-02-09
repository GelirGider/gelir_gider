import 'package:flutter/material.dart';

class Expense {
  final String category;
  final String description;
  final int price;
  final String time;
  final bool isExpense;

  Expense({this.description, this.price, this.time,this.category, this.isExpense});
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
