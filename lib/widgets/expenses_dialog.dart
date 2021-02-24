import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/expense_item.dart';

class ExpensesDialogWidget extends StatelessWidget {
  int categoryIndex;
  List<Expense> expenseList;

  ExpensesDialogWidget(this.categoryIndex, this.expenseList);

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<Expenses>(context, listen: false);
    final _theme = Provider.of<ThemeProvider>(context, listen: false);

    return SimpleDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      title: Text(
        "Harcamalar",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, height: 2.5, letterSpacing: 1.0),
      ),
      children: <Widget>[
        FutureBuilder(
          future: Provider.of<Expenses>(context, listen: false)
              .fetchAndSetExpenses(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : expenseProvider.expense.isEmpty
                      ? Center(
                          child: Text(S.of(context).ExpenseListNoneExpense),
                        )
                      : Container(
                          height: 300.0,
                          child: ListView.builder(
                            itemCount: expenseList.length,
                            itemBuilder: (context, index) {
                              //var category = expenseProvider.categories[categoryIndex];
                              var thisExpense = expenseList[index];
                              return Column(
                                children: [
                                  ExpenseItem(
                                    expense: thisExpense,
                                  ),
                                  Divider(
                                    height: 25,
                                    color: _theme.getTheme() == _theme.dark
                                        ? Color.fromRGBO(223, 81, 83, 1)
                                        : Colors.black,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
        ),
      ],
    );
  }
}
