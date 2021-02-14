import 'package:flutter/material.dart';
import 'package:gelir_gider/helpers/db_helper.dart';

class Expense {
  final String id;
  final String category;
  final String description;
  final double price;
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

  List<Expense> _day = [];
  List<Expense> get day {
    return [..._day];
  }

  List<Expense> _week = [];
  List<Expense> get week {
    return [..._week];
  }

  List<Expense> _month = [];
  List<Expense> get month {
    return [..._month];
  }

  List<Expense> _year = [];
  List<Expense> get year {
    return [..._year];
  }

  void setDates() {
    _day = _items.where((element) {
      var date = DateTime.parse(element.time);
      return DateTime.now().difference(date).inDays <= 0;
    });
    _week = _items.where((element) {
      var date = DateTime.parse(element.time);
      return DateTime.now().difference(date).inDays < 7;
    });
    _month = _items.where((element) {
      var date = DateTime.parse(element.time);
      return DateTime.now().difference(date).inDays < 30;
    });
    _year = _items.where((element) {
      var date = DateTime.parse(element.time);
      return DateTime.now().difference(date).inDays < 30;
    });
    notifyListeners();
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

  Future<int> delete(String id) async {
    _items.removeWhere((element) => element.id == id);
    return await DBHelper.delete(id);
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

  double calculateTotalMoney() {
    return calculateTotalExpense() - calculateTotalIncome();
  }

  double calculateTotalExpense() {
    Iterable<Expense> newlist = <Expense>[];
    newlist = _items.where((element) => element.isExpense == 'expense');

    var sum = 0.0;
    newlist.forEach((element) => sum += element.price);
    return sum;
  }

  double calculateTotalIncome() {
    Iterable<Expense> newlist = <Expense>[];
    newlist = _items.where((element) => element.isExpense == 'income');

    var sum = 0.0;
    newlist.forEach((element) => sum += element.price);
    return sum;
  }
}
