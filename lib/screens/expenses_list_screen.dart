import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/add_button.dart';
import 'package:gelir_gider/widgets/dissmissible_background.dart';
import 'package:gelir_gider/widgets/expense_item.dart';
import 'package:gelir_gider/widgets/money_widget.dart';
import 'package:gelir_gider/widgets/snackbar.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/widgets/theme_dialog_widget.dart';
import 'adding_expense_screen.dart';
import 'package:gelir_gider/modals/custom_theme_modal.dart';
import 'package:gelir_gider/screens/language_selection_screen.dart';

class ExpensesListScreen extends StatefulWidget {
  @override
  _ExpensesListScreenState createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends State<ExpensesListScreen> {
  Future<void> navigationFunction(context, scaffoldKey) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => AddingExpense(
          scaffoldKey: scaffoldKey,
        ),
      ),
    );
  }

  void showThemePicker() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ThemeDialogWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final _theme = Provider.of<CustomThemeModal>(context, listen: false);
    final snackBarr = Snackbar();

    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          key: scaffoldKey,
          appBar: GradientAppBar(
            actions: [
              FlatButton(
                onPressed: () {
                  showThemePicker();
                },
                child: Icon(
                  Icons.color_lens,
                  color: Theme.of(context).buttonColor,
                ),
              ),
              FlatButton(
                onPressed: () {
                  return Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => LanguageSelectionScreen(),
                    ),
                  );
                },
                child: Icon(
                  Icons.language,
                  color: Theme.of(context).buttonColor,
                ),
              ),
            ],
            title: Icon(Icons.attach_money),
            gradient: LinearGradient(colors: [Colors.red, Colors.purple]),
            bottom: TabBar(
              labelStyle: TextStyle(fontSize: 10),
              tabs: <Widget>[
                Tab(
                  text: 'GÜN',
                ),
                Tab(
                  text: 'HAFTA',
                ),
                Tab(
                  text: 'AY',
                ),
                Tab(
                  text: 'YIL',
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
                                  Divider(
                                    height: 25,
                                    color: _theme.getThemeData.brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(1223, 81, 83, 1)
                                        : Colors.black,
                                  ),
                                  MoneyWidget(
                                    expense: expenseProvider
                                        .calculateTotalIncome()
                                        .toStringAsFixed(2),
                                    income: expenseProvider
                                        .calculateTotalExpense()
                                        .toStringAsFixed(2),
                                    money: expenseProvider
                                        .calculateTotalMoney()
                                        .toStringAsFixed(2),
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
                                      itemCount: expenseProvider.expense.length,
                                      itemBuilder: (context, index) {
                                        var thisExpense =
                                            expenseProvider.expense[index];
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
                                                    ? Colors.grey
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
