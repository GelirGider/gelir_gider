import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:gelir_gider/widgets/expense_item.dart';
import 'package:gelir_gider/widgets/money_widget.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/widgets/theme_dialog_widget.dart';
import 'adding_expense_screen.dart';
import 'package:gelir_gider/modals/custom_theme_modal.dart';

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

  void showThemePicker(isEnglish) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ThemeDialogWidget(isEnglish);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final langState = Provider.of<LanguageHandler>(context, listen: false);
    final _theme = Provider.of<CustomThemeModal>(context, listen: false);
    final snackBarr = SnackBar(
      content: Container(
        child: Text(
          langState.isEnglish ? 'Transaction deleted' : 'İşlem silindi',
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
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(langState.isEnglish ? 'Add/Remove' : 'Ekle/Çıkar'),
          actions: [
            FlatButton(
              onPressed: () {
                showThemePicker(langState.isEnglish);
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
                Icons.settings,
                color: Theme.of(context).buttonColor,
              ),
            ),
          ],
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
                    child: langState.isEnglish
                        ? const Text(
                            'You have no Transactions  \n         Start Adding')
                        : const Text(
                            'Henüz ekleme yapılmadı \n Eklemeye başlayın !'),
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
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (_) {
                                          scaffoldKey.currentState
                                              .showSnackBar(snackBarr);
                                          setState(() {});
                                          return expenseProvider
                                              .delete(thisExpense.id);
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.delete,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => navigationFunction(context, scaffoldKey),
          child: Icon(Icons.post_add_rounded, color: Colors.white),
        ),
      ),
    );
  }
}
