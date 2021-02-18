import 'package:flutter/material.dart';
import 'package:gelir_gider/helpers/db_helper.dart';
import 'package:gelir_gider/utils/time_diff.dart';
import 'package:gelir_gider/widgets/category_item.dart';

class Expense {
  final String id;
  final CategoryItem category;
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
  bool init = false;
  bool init2 = false;

  int tabBarIndex = 0;
  void setTabBarIndex(int index) {
    setDates();
    tabBarIndex = index;
    if (tabBarIndex == 0) {
      _currentItems = _day;
    }
    if (tabBarIndex == 1) {
      _currentItems = _week;
    }
    if (tabBarIndex == 2) {
      _currentItems = _month;
    }
    if (tabBarIndex == 3) {
      _currentItems = _year;
    }
    notifyListeners();
  }

  int get TabBarIndex => tabBarIndex;

  List<Expense> _currentItems = [];
  List<Expense> get currentItems {
    return [..._currentItems];
  }

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
    print(init);
    var temp = <Expense>[];
    var temp1 = <Expense>[];
    var temp2 = <Expense>[];
    var temp3 = <Expense>[];

    _items.forEach((element) {
      var dif = TimeDiff(element.time).diff();
      if (dif == 0) {
        temp.add(element);
      } else if (dif < 7) {
        temp1.add(element);
      } else if (dif < 30) {
        temp2.add(element);
      } else if (TimeDiff(element.time).diff() < 365) {
        temp3.add(element);
      }
    });
    _day = temp;
    _week = temp1;
    _month = temp2;
    _year = temp3;
    if (!init) {
      _currentItems = _day;
      init = true;
    }
    notifyListeners();
  }

  void addExpense(Expense newExpense) async {
    _items.add(newExpense);
    notifyListeners();
    await DBHelper.insert(
      'user_expenses',
      {
        'id': newExpense.id,
        'category': newExpense.category.index,
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

  Future<void> fetchAndSetExpenses(context) async {
    final dataList = await DBHelper.getData('user_expenses');
    _items = dataList
        .map(
          (item) => Expense(
            id: item['id'],
            category: CategoryItem(context,(item['category'])),
            isExpense: item['isExpense'],
            time: item['time'],
            price: item['price'],
            description: item['description'],
          ),
        )
        .toList();
    if (!init2) {
      setTabBarIndex(0);
      init2 = true;
    }
    notifyListeners();
  }

  double calculateTotalMoney() {
    return calculateTotalIncome() - calculateTotalExpense();
  }

  double calculateTotalExpense() {
    Iterable<Expense> newlist = <Expense>[];
    newlist = _currentItems.where((element) => element.isExpense == 'expense');

    var sum = 0.0;
    newlist.forEach((element) => sum += element.price);
    return sum;
  }

  double getPercantage() {
    var totalexp = calculateTotalExpense();
    var totalinc = calculateTotalIncome();
    return (totalexp/(totalinc+totalexp));
  }

  double calculateTotalIncome() {
    Iterable<Expense> newlist = <Expense>[];
    newlist = _currentItems.where((element) => element.isExpense == 'income');

    var sum = 0.0;
    newlist.forEach((element) => sum += element.price);
    return sum;
  }
}
