import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/add_button.dart';
import 'package:gelir_gider/widgets/dissmissible_background.dart';
import 'package:gelir_gider/widgets/expense_item.dart';
import 'package:gelir_gider/widgets/main_drawer.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'adding_expense_screen.dart';
import 'package:gelir_gider/modals/custom_theme_modal.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ExpensesListScreen extends StatefulWidget {
  @override
  _ExpensesListScreenState createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends State<ExpensesListScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      return Provider.of<Expenses>(context, listen: false).setTabBarIndex(0);
    });
    super.initState();
  }

  Future<void> navigationFunction(context, scaffoldKey) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => AddingExpense(
          scaffoldKey: scaffoldKey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final _theme = Provider.of<CustomThemeModal>(context, listen: false);
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
          drawer: MainDrawer(),
          key: scaffoldKey,
          appBar: GradientAppBar(
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
                .fetchAndSetExpenses(context),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<Expenses>(
                    child: Center(
                      child:
                          Text('Henüz ekleme yapılmadı \n Eklemeye başlayın !'),
                    ),
                    builder: (ctx, expenseProvider, ch) => expenseProvider
                            .expense.isEmpty
                        ? ch
                        : LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              S.of(context).MoneyWidgetIncome,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              expenseProvider.calculateTotalIncome().toStringAsFixed(1),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CircularPercentIndicator(
                                        radius: 130.0,
                                        animation: true,
                                        animationDuration: 750,
                                        lineWidth: 15.0,
                                        percent: expenseProvider.getPercantage(),
                                        center: Text(
                                          expenseProvider
                                              .calculateTotalMoney()
                                              .toStringAsFixed(1),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        circularStrokeCap: CircularStrokeCap.butt,
                                        backgroundColor: Colors.green,
                                        progressColor: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              S.of(context).MoneyWidgetExpense,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              expenseProvider.calculateTotalExpense().toStringAsFixed(1),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 25,
                                    color: _theme.getThemeData.brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(1223, 81, 83, 1)
                                        : Colors.black,
                                  ),
                                  Flexible(
                                    child: ListView.builder(
                                      itemCount:
                                          expenseProvider.currentItems.length,
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
                                                color: _theme.getThemeData
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Color.fromRGBO(1223, 81, 83, 1)
                                                    : Colors.black,
                                              ),
                                            ],
                                          ),
                                          direction:
                                              DismissDirection.endToStart,
                                          onDismissed: (_) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                              (_) => scaffoldKey.currentState
                                                  .showSnackBar(snackBarr),
                                            );
                                            Future.delayed(Duration(seconds: 1))
                                                .then(
                                              (value) => setState(() {}),
                                            );
                                            return expenseProvider
                                                .delete(thisExpense.id);
                                          },
                                          background: DismissibleBackground(),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => navigationFunction(context, scaffoldKey),
            child: AddButton(),
          ),
        ),
      ),
    );
  }
}
