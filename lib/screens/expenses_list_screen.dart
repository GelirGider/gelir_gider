import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:gelir_gider/widgets/account_changer.dart';
import 'package:gelir_gider/widgets/add_button.dart';
import 'package:gelir_gider/widgets/main_drawer.dart';
import 'package:gelir_gider/widgets/money_widget.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adding_expense_screen.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:gelir_gider/widgets/main_page_category_modal.dart';

class ExpensesListScreen extends StatefulWidget {
  @override
  _ExpensesListScreenState createState() => _ExpensesListScreenState();
}

List iconsYear = [
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      '2019',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      '2020',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      '2021',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
];

List iconsMonth = [
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      'January',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      'February',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      'March',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      'April',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      'May',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      'June',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      'July',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      'August',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      'September',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      'October',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      'November',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      'December',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
];

List iconsWeek = [
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      '1',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      '2',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      '3',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colours.pink,
    child: Text(
      '4',
      style: TextStyle(
        color: Colours.white,
      ),
    ),
  ),
];

class _ExpensesListScreenState extends State<ExpensesListScreen> {
  var languageIndex;

  Future<String> _getPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    languageIndex = prefs.getInt('language') ?? 0;
    Provider.of<Languages>(context, listen: false).setLanguage(languageIndex);
    return 'Başarılı';
  }

  @override
  void initState() {
    _getPrefs().then((value) => {});

    Future.delayed(Duration.zero).then((_) {
      Provider.of<Expenses>(context, listen: false).setCategories(context);
      return Provider.of<Expenses>(context, listen: false).setTabBarIndex(0);
    });
    super.initState();
  }

  Future<void> navigationFunction(context, scaffoldKey) {
    return Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (ctx) => AddingExpense(
        scaffoldKey: scaffoldKey,
      ),
    ))
        .then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var tabIndex = 0;

    final scaffoldKey = GlobalKey<ScaffoldState>();
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    final expenseProvider = Provider.of<Expenses>(context, listen: false);
    var isDark = _theme.getTheme() == _theme.dark;
    expenseProvider.getSymbol();

    final snackBarr = SnackBar(
      content: Container(
        child: Text(
          'İşlem silindi',
          style: TextStyle(
            color: Theme.of(context).textTheme.overline.color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: Colours.red,
    );

    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          endDrawer: MainDrawer(),
          key: scaffoldKey,
          appBar: GradientAppBar(
            leading: AccountChanger(
              onPressed1: () async {
                await expenseProvider.setPersonal();
                expenseProvider.setTabBarIndex(tabIndex);
                await Navigator.of(context).pop();
                setState(() {});
              },
              onPressed2: () async {
                await expenseProvider.setCorporate();
                expenseProvider.setTabBarIndex(tabIndex);
                await Navigator.of(context).pop();
                setState(() {});
              },
              isPersonal: expenseProvider.isPersonal,
            ),
            centerTitle: true,

            ///change drawer icon
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    size: 30.0,
                  ),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,

                  ///it opens a drawer
                ),
              ),
            ],
            title: Icon(Icons.attach_money),
            gradient: LinearGradient(
                colors: Colours.getGradientColors(isDark),),
            bottom: TabBar(
              onTap: (index) {
                Provider.of<Expenses>(context, listen: false)
                    .setTabBarIndex(index);
                tabIndex = index;
                print(index);
                setState(() {});
              },
              labelStyle: TextStyle(fontSize: 12),
              tabs: <Widget>[
                Tab(text: S.of(context).TabBarDay),
                Tab(text: S.of(context).TabBarWeek),
                Tab(text: S.of(context).TabBarMonth),
                Tab(text: S.of(context).TabBarYear),
              ],
            ),
          ),
          body: Container(
            child: TabBarView(
              children: [
                FutureBuilder(
                  future: Provider.of<Expenses>(context, listen: false)
                      .fetchAndSetExpenses(),
                  builder: (ctx, snapshot) => snapshot.connectionState ==
                          ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : expenseProvider.currentItems.isEmpty
                          ? Center(
                              child: Text(
                                S.of(context).ExpenseListNoneExpense,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                MoneyWidget(
                                  income: expenseProvider
                                      .calculateTotalIncome()
                                      .toStringAsFixed(1),
                                  money: expenseProvider
                                      .calculateTotalMoney()
                                      .toStringAsFixed(1),
                                  expense: expenseProvider
                                      .calculateTotalExpense()
                                      .toStringAsFixed(1),
                                  percentage: expenseProvider.getPercentage,
                                ),
                                Divider(
                                  height: 25,
                                  color: Colours.getBlackOrWhite(isDark),
                                ),
                                Flexible(
                                  flex: 10,
                                  child: Consumer<Expenses>(
                                    builder: (context, expenseProvider, child) {
                                      return ListView.builder(
                                        itemCount:
                                            expenseProvider.currentItems.length,
                                        itemBuilder: (context, index) {
                                          var category = expenseProvider
                                              .currentItems.keys
                                              .toList()[index];
                                          var list = expenseProvider
                                              .currentItems.values
                                              .toList()[index];
                                          var currency = expenseProvider.symbol;
                                          return Column(
                                            children: [
                                              MainPageCategoryModal(
                                                category: category,
                                                list: list,
                                                currency: currency,
                                              ),
                                              Divider(
                                                height: 25,
                                                color: Colours.getBlackOrWhite(isDark),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(),
                                )
                              ],
                            ),
                ),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 7 / 5,
                    padding: EdgeInsets.all(10.0),
                    crossAxisCount: 2,
                    children: List.generate(
                      iconsWeek.length,
                      (index) {
                        return FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (ctx) => ExpensesListScreen(),
                            ));
                          },
                          child: iconsWeek[index],
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 1.0,
                    padding: EdgeInsets.all(10.0),
                    crossAxisCount: 3,
                    children: List.generate(
                      iconsMonth.length,
                      (index) {
                        return FlatButton(
                          onPressed: () {},
                          child: iconsMonth[index],
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 1.0,
                    padding: EdgeInsets.all(10.0),
                    crossAxisCount: 3,
                    children: List.generate(
                      iconsYear.length,
                      (index) {
                        return FlatButton(
                          onPressed: () {},
                          child: iconsYear[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () => navigationFunction(context, scaffoldKey),
            child: AddButton(),
          ),
        ),
      ),
    );
  }
}
