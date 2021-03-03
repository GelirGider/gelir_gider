import 'package:flutter/material.dart';
import 'package:gelir_gider/helpers/db_helper.dart';
import 'package:gelir_gider/utils/time_diff.dart';
import 'package:gelir_gider/widgets/components/category_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';
import 'package:date_utils/date_utils.dart';
import 'categories.dart';

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

  @override
  String toString() {
    return 'Expense{id: $id, category: $category, description: $description, price: $price, time: $time, isExpense: $isExpense}';
  }
}

class Expenses with ChangeNotifier {
  static const modePrefKeyIsIndividual = 'isIndividual';
  static const modePrefKeyCurrency = 'currency';

  Map<int, List<Expense>> _categoryAndItems = {};
  var personalCategoryTitleList = [];
  var corporateCategoryTitleList = [];
  var _personalCategories = [];
  var _corporateCategories = [];
  int _currentCategoryId = 0;
  int _tabBarIndex = 0;
  bool _init = false;
  bool _init2 = false;
  Map<int, List<Expense>> currentMap = {};

  var imgList = Categories.getPersonalImageList();
  var imgListCorporate = Categories.getCorporateImageList();

  void setCategories(context) {
    corporateCategoryTitleList =
        Categories.getCorporateCategoryListTitles(context);
    _corporateCategories = Categories.getCorporateCategories(context);

    personalCategoryTitleList =
        Categories.getPersonalCategoryListTitles(context);
    _personalCategories = Categories.getPersonalCategories(context);
  }

  int get currentCategoryId => _currentCategoryId;

  void setCurrentCategory(int id) {
    _currentCategoryId = id;
    notifyListeners();
  }

  CategoryItem get CurrentCategory => categories[currentCategoryId];

  List<CategoryItem> get categories {
    return [..._personalCategories];
  }

  List<CategoryItem> get corporateCategories {
    return [..._corporateCategories];
  }

  Map<int, List<Expense>> get categoryAndItems => _categoryAndItems;

  set categoryAndItems(Map<int, List<Expense>> value) {
    _categoryAndItems = value;
  }

  int get TabBarIndex => _tabBarIndex;

  Map<int, List<Expense>> _currentItems = {};
  Map<int, List<Expense>> get currentItems {
    return {..._currentItems};
  }

  List<Expense> _items = [];
  List<Expense> get expense {
    return [..._items];
  }

  Map<int, List<Expense>> _days = {};
  Map<int, List<Expense>> get day {
    return {..._days};
  }

  Map<int, List<Expense>> _weeks = {};
  Map<int, List<Expense>> get week {
    return {..._weeks};
  }

  Map<int, List<Expense>> _months = {};
  Map<int, List<Expense>> get month {
    return {..._months};
  }

  Map<int, List<Expense>> _years = {};
  Map<int, List<Expense>> get year {
    return {..._years};
  }

  Map<int, List<Expense>> groupExpensesByCategories(List<Expense> expenses) {
    final groups = groupBy(expenses, (Expense e) => e.category);
    return groups;
  }

//  List<Expense> getListFromMap(Map<int, List<Expense>> map) {
//    var sum;
//    var valuesList = map.values;
//    valuesList.forEach((element) {
//      sum = sum + element;
//    });
//    notifyListeners();
//    return sum;
//  }

  void setTabBarIndex(int index) {
    setDates();
    _tabBarIndex = index;
    if (_tabBarIndex == 0) {
      _currentItems = _days;
    }
    if (_tabBarIndex == 1) {
      _currentItems = _weeks;
    }
    if (_tabBarIndex == 2) {
      _currentItems = _months;
    }
    if (_tabBarIndex == 3) {
      _currentItems = _years;
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
    _days = groupExpensesByCategories(temp);
    _weeks = groupExpensesByCategories(temp1);
    _months = groupExpensesByCategories(temp2);
    _years = groupExpensesByCategories(temp3);
    if (!_init) {
      _currentItems = _days;
      _init = true;
    }
    notifyListeners();
  }

  //----------------------------------------------------------------------------
  // TO CHECK IS PERSONAL
  Future<bool> getMode() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(modePrefKeyIsIndividual) ?? true;
  }

  Future<void> setMode(isIndividual) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(modePrefKeyIsIndividual, isIndividual);
  }

  var isPersonal = true;

  Future<void> setPersonal() async {
    await setMode(true);
    await getMode().then((value) => isPersonal = value);
    _items.clear();
    await fetchAndSetExpenses();
    setDates();
    setTabBarIndex(_tabBarIndex);
    notifyListeners();
  }

  Future<void> setCorporate() async {
    await setMode(false);
    await getMode().then((value) => isPersonal = value);
    _items.clear();
    await fetchAndSetExpenses();
    setDates();
    setTabBarIndex(_tabBarIndex);
    notifyListeners();
  }

//---------------------------------------------------------------------------
  int selectedYear = 2021;
  int selectedMonth = 0;
  int selectedDay = 0;
  String selectedWeek = ' ';
  int selectedPage = 0;

  void setSelectedYear(int num) {
    selectedYear = num;
    notifyListeners();
  }

  void setSelectedMonth(int num) {
    selectedMonth = num;
    notifyListeners();
  }

  void setSelectedDay(int num) {
    selectedDay = num;
    notifyListeners();
  }

  void setSelectedWeek(String num) {
    selectedWeek = num;
    notifyListeners();
  }

  void setSelectedPage(int num) {
    selectedPage = num;
    notifyListeners();
  }

  Iterable<int> getCurrentYears() {
    var map = groupBy(_items, (Expense e) => int.parse(e.time.split('-')[0]));
    var years = map.keys;
    currentMap = map;
    notifyListeners();
    return years;
  }

  Iterable<int> getCurrentMonths() {
    var yearOfExpenses = currentMap[selectedYear];
    var map =
        groupBy(yearOfExpenses, (Expense e) => int.parse(e.time.split('-')[1]));
    var months = map.keys;
    currentMap = map;
    notifyListeners();
    return months;
  }

  int getLastDayOfMonth() {
    final date = DateTime(selectedYear, (selectedMonth + 1));
    final lastDay = Utils.lastDayOfMonth(date);
    print('Last day in month : ${lastDay.day}');
    return lastDay.day;
  }

  Iterable<int> getCurrentDays(int startDay, int endDay) {
    var startDate = DateTime.parse(selectedYear.toString() +
        '-' +
        fixAsDate(selectedMonth + 1) +
        '-' +
        fixAsDate(startDay));
    var endDate = DateTime.parse(selectedYear.toString() +
        '-' +
        fixAsDate(selectedMonth + 1) +
        '-' +
        fixAsDate(endDay));
    var monthOfExpenses = currentMap[selectedMonth + 1];

    var map = groupBy(monthOfExpenses, (Expense e) {
          var curDate = DateTime.parse(e.time);
          print(curDate.toString());
          if ((curDate.isAfter(startDate) && curDate.isBefore(endDate)) ||
              ((curDate == startDate) || (curDate == endDate))) {
            return int.parse(e.time.split('-')[2]);
          }
        }) ??
        {};

    var days = map.keys;
    print(days.toString());
    currentMap = map;
    notifyListeners();
    return days;
  }

  bool checkWeekNull(int startDay, int endDay) {
    var startDate = DateTime.parse(selectedYear.toString() +
        '-' +
        fixAsDate(selectedMonth + 1) +
        '-' +
        fixAsDate(startDay));
    var endDate = DateTime.parse(selectedYear.toString() +
        '-' +
        fixAsDate(selectedMonth + 1) +
        '-' +
        fixAsDate(endDay));
    var monthOfExpenses = currentMap[selectedMonth + 1];

    var map = groupBy(monthOfExpenses, (Expense e) {
          var curDate = DateTime.parse(e.time);
          print(curDate.toString());
          if ((curDate.isAfter(startDate) && curDate.isBefore(endDate)) ||
              ((curDate == startDate) || (curDate == endDate))) {
            return int.parse(e.time.split('-')[2]);
          }
        });
    print(map.keys.toString()+" "+map.keys.contains(null).toString()+" "+startDay.toString());
    map.removeWhere((key, value) => key==null);
    if (map.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String fixAsDate(date) {
    if (date < 10) {
      return '0' + (date).toString();
    } else {
      return (date).toString();
    }
  }

  //----------------------------------------------------------------------------

  var symbol = '€';
  // TO CHECK CURRENCY
  Future<void> setCurrency(String currencySymbol) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(modePrefKeyCurrency, currencySymbol);
    notifyListeners();
    await getSymbol();
    notifyListeners();
    print('setCurrency::::::::::::$currencySymbol');
  }

  Future<String> getCurrency() async {
    var prefs = await SharedPreferences.getInstance();
    return await prefs.getString(modePrefKeyCurrency) ?? '₺';
  }

  Future<void> getSymbol() async {
    var prefs = await SharedPreferences.getInstance();
    symbol = await prefs.getString(modePrefKeyCurrency) ?? '₺';
    notifyListeners();
  }
  //----------------------------------------------------------------------------

  Future<void> addExpense(Expense newExpense) async {
    _items.add(newExpense);
    setTabBarIndex(_tabBarIndex);
    notifyListeners();
    await DBHelper.insert(
      isPersonal ? 'user_expenses' : 'corporation_expenses',
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
    return await DBHelper.delete(
        isPersonal ? 'user_expenses' : 'corporation_expenses', id);
  }

  Future<void> fetchAndSetExpenses() async {
    final dataList = await DBHelper.getData(
        isPersonal ? 'user_expenses' : 'corporation_expenses');

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
    if (!_init2) {
      setTabBarIndex(0);
      _init2 = true;
    }
    notifyListeners();
  }

  //----------------------------------------------------------------------------

  double calculateTotalMoney(list) {
    return calculateTotalIncome(list) + calculateTotalExpense(list);
  }

  double calculateTotalExpense(list) {
    var sum = 0.0;
    list.values.forEach((element) {
      element
          .where((expense) => expense.isExpense == 'expense')
          .forEach((element) {
        sum += element.price;
      });
    });
    return sum;
  }

  double calculateTotalIncome(list) {
    var sum = 0.0;
    list.values.forEach((element) {
      element
          .where((expense) => expense.isExpense == 'income')
          .forEach((element) {
        sum += element.price;
      });
    });
    return sum;
  }

  double getPercentage(list) {
    var income = calculateTotalIncome(list);
    var expense = calculateTotalExpense(list).abs();
    return income / (expense + income);
  }

//  List<Expense> getYearList(year) {
//    var sum = _items.where((element) {
//      var time = DateTime.parse(element.time);
//      return (time.year == year);
//    }).toList();
//    return sum;
//  }
//
//  List<Expense> getMonthList(month) {
//    var sum = _items.where((element) {
//      var time = DateTime.parse(element.time);
//      return (time.year == selectedYear) && (time.month == month + 1);
//    }).toList();
//    return sum;
//  }
//
//  List<Expense> getWeekList(String week) {
//    var weekStr = week.split(' ')[0];
//    var startDay = int.parse(weekStr.split('-')[0]);
//    var endDay = int.parse(weekStr.split('-')[1]);
//    var sum = _items.where((element) {
//      var time = DateTime.parse(element.time);
//      return (time.year == selectedYear) &&
//          (time.month == selectedMonth + 1) &&
//          (time.day >= startDay) &&
//          (time.day <= endDay);
//    }).toList();
//    return sum;
//  }
//
//  List<Expense> getDayList() {
//    var year = selectedYear;
//    var month = selectedMonth + 1;
//    var day = selectedDay;
//    var sum = _items.where((element) {
//      var time = DateTime.parse(element.time);
//      return (time.year == year) && (time.month == month) && (time.day == day);
//    }).toList();
//    return sum;
//  }
}
