import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:gelir_gider/widgets/expense_item.dart';
import 'package:gelir_gider/widgets/money_widget.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/widgets/theme_dialog_widget.dart';
import 'adding_expense_screen.dart';

class ExpensesListScreen extends StatefulWidget {
  @override
  _ExpensesListScreenState createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends State<ExpensesListScreen> {

  void showThemePicker(bool isEnglish) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ThemeDialogWidget(isEnglish);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final langState = Provider.of<LanguageHandler>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(langState.isEnglish ? 'Add/Remove' : 'Ekle/Çıkar'),
          actions: [
            FlatButton(
              onPressed: (){
                showThemePicker(langState.isEnglish);
              },
          child: Icon(
        Icons.color_lens,
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
                            'Got no Expenses  yet \nStart adding some !')
                        : const Text(
                            'Henüz ekleme yapılmadı \nEklemeye başlayın !'),
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
                                  color:Theme.of(context).accentColor,
                                ),
                                MoneyWidget(
                                  expense: expenseProvider
                                      .calculateTotalExpense()
                                      .toString(),
                                  income: expenseProvider
                                      .calculateTotalIncome()
                                      .toString(),
                                  money: expenseProvider
                                      .calculateTotalMoney()
                                      .toString(),
                                ),
                                Divider(
                                  height: 25,
                                  color:Theme.of(context).accentColor,
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
                                            Divider(),
                                          ],
                                        ),
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (direction) {
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
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddingExpense())),
          child: Icon(Icons.post_add_rounded, color: Colors.white),
        ),
      ),
    );
  }
}
