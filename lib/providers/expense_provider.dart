import 'package:flutter/material.dart';
import 'package:gelir_gider/helpers/db_helper.dart';

class Expense {
  final String id;
  final String category;
  final String description;
  final int price;
  final String time;
  final String isExpense;

  Expense({
    this.id,
    this.description,
    this.price,
    this.time,
    this.category,
    this.isExpense,
  });
}

class Expenses with ChangeNotifier {
  List<Expense> _items = [];
  List<Expense> get expense {
    return [..._items];
  }

  void addExpense(Expense newExpense) async {
    _items.add(newExpense);
    notifyListeners();
    await DBHelper.insert(
      'user_expenses',
      {
        'id': newExpense.id,
        'category': newExpense.category,
        'isExpense': newExpense.isExpense,
        'time': newExpense.time,
        'price': newExpense.price,
        'description': newExpense.description,
      },
    );
  }

  Future<int> delete(String paramId) async {
    var element = _items.firstWhere((element) => element.id == paramId);
    print('element:::::::::::::::::::::::::${element.price}');
    var id = _items.indexOf(element);
    print('id::::::::::::::::::::::::::::::$id');
    await DBHelper.delete(id);
  }

  Future<void> fetchAndSetExpenses() async {
    final dataList = await DBHelper.getData('user_expenses');
    print('fetchAndSetExpenses dataList: $dataList');
    _items = dataList
        .map(
          (item) => Expense(
            id: item['id'],
            category: item['category'],
            isExpense: item['isExpense'],
            time: item['time'],
            price: item['price'],
            description: item['description'],
          ),
        )
        .toList();
    notifyListeners();
  }

  int calculateTotalMoney() {
    return calculateTotalIncome() - calculateTotalExpense();
  }

  int calculateTotalExpense() {
    List<Expense> newlist = [];
    newlist = _items.where((element) => element.isExpense == 'expense');

    var sum = 0;
    newlist.forEach((element) => sum += element.price);
    return sum;
  }

  int calculateTotalIncome() {
    List<Expense> newlist = [];
    newlist = _items.where((element) => element.isExpense == 'income');

    var sum = 0;
    newlist.forEach((element) => sum += element.price);
    return sum;
  }
}
