import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/helpers/db_helper.dart';
import 'package:gelir_gider/utils/time_diff.dart';
import 'package:gelir_gider/widgets/category_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class Expense {
  final String id;
  final int category;
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
  static const modePrefKey = 'isIndividual';
  Map<int, List<Expense>> _categoryAndItems = {};
  var categoryList = [];
  var _categories = [];
  int _currentCategoryId = 0;
  int tabBarIndex = 0;
  bool init = false;
  bool init2 = false;

  var imgList = [
    Image.asset('assets/categories/dues.png'),
    Image.asset('assets/categories/shopping.png'),
    Image.asset('assets/categories/education.png'),
    Image.asset('assets/categories/entertainment.png'),
    Image.asset('assets/categories/hire.png'),
    Image.asset('assets/categories/selfcare.png'),
    Image.asset('assets/categories/bill.png'),
    Image.asset('assets/categories/health.png'),
    Image.asset('assets/categories/fix.png'),
    Image.asset('assets/categories/holiday.png'),
    Image.asset('assets/categories/food.png'),
    Image.asset('assets/categories/other.png'),
  ];

  void setCategories(context) {
    categoryList = [
      S.of(context).CategoryDues,
      S.of(context).CategoryShopping,
      S.of(context).CategoryEducation,
      S.of(context).CategoryEntertainment,
      S.of(context).CategoryRent,
      S.of(context).CategorySelfcare,
      S.of(context).CategoryPayment,
      S.of(context).CategoryHealth,
      S.of(context).CategoryRepair,
      S.of(context).CategoryVacation,
      S.of(context).CategoryEatDrink,
      S.of(context).CategoryOthers,
    ];
    _categories = <CategoryItem>[
      CategoryItem(
          categoryImg: imgList[0], categoryName: categoryList[0], index: 0),
      CategoryItem(
          categoryImg: imgList[1], categoryName: categoryList[1], index: 1),
      CategoryItem(
          categoryImg: imgList[2], categoryName: categoryList[2], index: 2),
      CategoryItem(
          categoryImg: imgList[3], categoryName: categoryList[3], index: 3),
      CategoryItem(
          categoryImg: imgList[4], categoryName: categoryList[4], index: 4),
      CategoryItem(
          categoryImg: imgList[5], categoryName: categoryList[5], index: 5),
      CategoryItem(
          categoryImg: imgList[6], categoryName: categoryList[6], index: 6),
      CategoryItem(
          categoryImg: imgList[7], categoryName: categoryList[7], index: 7),
      CategoryItem(
          categoryImg: imgList[8], categoryName: categoryList[8], index: 8),
      CategoryItem(
          categoryImg: imgList[9], categoryName: categoryList[9], index: 9),
      CategoryItem(
          categoryImg: imgList[10], categoryName: categoryList[10], index: 10),
      CategoryItem(
          categoryImg: imgList[11], categoryName: categoryList[11], index: 11),
    ];
  }

  int get currentCategoryId => _currentCategoryId;

  void setCurrentCategory(int id) {
    _currentCategoryId = id;
    notifyListeners();
  }

  CategoryItem get CurrentCategory => categories[currentCategoryId];

  List<CategoryItem> get categories {
    return [..._categories];
  }

  Map<int, List<Expense>> get categoryAndItems => _categoryAndItems;

  set categoryAndItems(Map<int, List<Expense>> value) {
    _categoryAndItems = value;
  }

  int get TabBarIndex => tabBarIndex;

  Map<int, List<Expense>> _currentItems = {};
  Map<int, List<Expense>> get currentItems {
    return {..._currentItems};
  }

  List<Expense> _items = [];
  List<Expense> get expense {
    return [..._items];
  }

  Map<int, List<Expense>> _day = {};
  Map<int, List<Expense>> get day {
    return {..._day};
  }

  Map<int, List<Expense>> _week = {};
  Map<int, List<Expense>> get week {
    return {..._week};
  }

  Map<int, List<Expense>> _month = {};
  Map<int, List<Expense>> get month {
    return {..._month};
  }

  Map<int, List<Expense>> _year = {};
  Map<int, List<Expense>> get year {
    return {..._year};
  }

  Map<int, List<Expense>> groupExpensesByCategories(List<Expense> expenses) {
    final groups = groupBy(expenses, (Expense e) => e.category);
    return groups;
  }

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

  void setDates() {
    List<Expense> temp = [];
    List<Expense> temp1 = [];
    List<Expense> temp2 = [];
    List<Expense> temp3 = [];

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
    _day = groupExpensesByCategories(temp);
    _week = groupExpensesByCategories(temp);
    _month = groupExpensesByCategories(temp);
    _year = groupExpensesByCategories(temp);
    if (!init) {
      _currentItems = _day;
      init = true;
    }
    notifyListeners();
  }

  //----------------------------------------------------------------------------

  Future<bool> getMode() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(modePrefKey) ?? true;
  }

  Future<void> setMode(isIndividual) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(modePrefKey, isIndividual);
  }

  var isPersonal = true;

  Future<void> setPersonal() async {
    await setMode(true);
    await getMode().then((value) => isPersonal = value);
    _items.clear();
    await fetchAndSetExpenses();
    setDates();
    setTabBarIndex(tabBarIndex);
    notifyListeners();
  }

  Future<void> setCorporate() async {
    await setMode(false);
    await getMode().then((value) => isPersonal = value);
    _items.clear();
    await fetchAndSetExpenses();
    setDates();
    setTabBarIndex(tabBarIndex);
    notifyListeners();
  }
  //----------------------------------------------------------------------------

  Future<void> addExpense(Expense newExpense) async {
    // var isPersonal = true;
    _items.add(newExpense);
    setTabBarIndex(tabBarIndex);
    notifyListeners();
    isPersonal
        ? await DBHelper.insert(
            'user_expenses',
            {
              'id': newExpense.id,
              'category': newExpense.category,
              'isExpense': newExpense.isExpense,
              'time': newExpense.time,
              'price': newExpense.price,
              'description': newExpense.description,
            },
          )
        : await DBHelper.insert2(
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

  Future<void> delete(String id) async {
    //var isPersonal = true;
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    return isPersonal ? await DBHelper.delete(id) : await DBHelper.delete2(id);
  }

  Future<void> fetchAndSetExpenses() async {
    //var isPersonal = true;
    final dataList = isPersonal
        ? await DBHelper.getData('user_expenses')
        : await DBHelper.getData2('user_expenses');

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
    if (!init2) {
      setTabBarIndex(0);
      init2 = true;
    }
    notifyListeners();
  }

  //----------------------------------------------------------------------------

  double calculateTotalMoney() {
    return calculateTotalIncome() + calculateTotalExpense();
  }

  double calculateTotalExpense() {
    var sum = 0.0;
    _currentItems.values.forEach((element) {
      element
          .where((expense) => expense.isExpense == 'expense')
          .forEach((element) {
        sum += element.price;
      });
    });
    return sum;
  }

  double calculateTotalIncome() {
    var sum = 0.0;
    _currentItems.values.forEach((element) {
      element
          .where((expense) => expense.isExpense == 'income')
          .forEach((element) {
        sum += element.price;
      });
    });
    return sum;
  }

  double get getPercentage {
    var income = calculateTotalIncome();
    var expense = calculateTotalExpense().abs();
    return income / (expense + income);
  }
}
