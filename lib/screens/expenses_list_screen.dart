import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/add_button.dart';
import 'package:gelir_gider/widgets/dissmissible_background.dart';
import 'package:gelir_gider/widgets/expense_item.dart';
import 'package:gelir_gider/widgets/main_drawer.dart';
import 'package:gelir_gider/widgets/money_widget.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adding_expense_screen.dart';
import 'package:gelir_gider/providers/custom_theme_modal.dart';
import 'package:gelir_gider/providers/language_provider.dart';

class ExpensesListScreen extends StatefulWidget {
  @override
  _ExpensesListScreenState createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends State<ExpensesListScreen> {

  var languageIndex;

  Future<String> _getPrefs() async{
    var prefs = await SharedPreferences.getInstance();
    languageIndex = prefs.getInt('language');
    Provider.of<Languages>(context, listen: false)
        .setLanguage(languageIndex);
    return 'Başarılı';
  }

  @override
  void initState() {
    _getPrefs().then((value) => {
      if(languageIndex == null){
        print('null')
        //Yeni language ekranı açılacak
      }
    });
    
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
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final _theme = Provider.of<CustomThemeModal>(context, listen: false);
    final expenseProvider = Provider.of<Expenses>(context, listen: false);
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
      backgroundColor: Colors.red,
    );
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          endDrawer: MainDrawer(),
          key: scaffoldKey,
          appBar: GradientAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.switch_account,
                color: Colors.white,
              ),
              onPressed: () {
                ///???
              },
            ) ,
            actions: [],
            centerTitle: true,
            title: Icon(Icons.attach_money),
            gradient: LinearGradient(
                colors: _theme.getThemeData.brightness == Brightness.dark
                    ? [Color(0xff212121), Color(0xff212121)]
                    : [Colors.purple, Colors.pink]),
            bottom: TabBar(
              onTap: (index) {
                Provider.of<Expenses>(context, listen: false)
                    .setTabBarIndex(index);
                print(index);
                setState(() {});
              },
              labelStyle: TextStyle(fontSize: 10),
              tabs: <Widget>[
                Tab(
                  text: S.of(context).TabBarDay,
                ),
                Tab(
                  text: S.of(context).TabBarWeek,
                ),
                Tab(
                  text: S.of(context).TabBarMonth,
                ),
                Tab(
                  text: S.of(context).TabBarYear,
                ),
              ],
            ),
          ),
          body: FutureBuilder(
            future: Provider.of<Expenses>(context, listen: false)
                .fetchAndSetExpenses(),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : expenseProvider.expense.isEmpty
                    ? Center(
                        child: Text(S.of(context).ExpenseListNoneExpense),
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
                            color: _theme.getThemeData.brightness ==
                                    Brightness.dark
                                ? Color.fromRGBO(1223, 81, 83, 1)
                                : Colors.black,
                          ),
                          Flexible(
                            flex: 10,
                            child: ListView.builder(
                              itemCount: expenseProvider.currentItems.length,
                              itemBuilder: (context, index) {
                                var thisExpense =
                                    expenseProvider.currentItems[index];
                                return Dismissible(
                                  key: UniqueKey(),
                                  child: Column(
                                    children: [
                                      ExpenseItem(
                                        expense: thisExpense,
                                      ),
                                      Divider(
                                        height: 25,
                                        color: _theme.getThemeData.brightness ==
                                                Brightness.dark
                                            ? Color.fromRGBO(1223, 81, 83, 1)
                                            : Colors.black,
                                      ),
                                    ],
                                  ),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (_) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) => scaffoldKey
                                            .currentState
                                            .showSnackBar(snackBarr)
                                            .setState);
                                    return expenseProvider
                                        .delete(thisExpense.id);
                                  },
                                  background: DismissibleBackground(),
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
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () => navigationFunction(context, scaffoldKey),
            child: AddButton(),
          ),
        ),
      ),
    );
  }
}
