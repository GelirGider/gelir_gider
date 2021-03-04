import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/components/expense_item.dart';
import 'package:gelir_gider/widgets/components/dissmissible_background.dart';
class ExpensesDialogWidget extends StatelessWidget {
  final int categoryIndex;
  final List<Expense> expenseList;
  final String currency;

  const ExpensesDialogWidget(
      {Key key, this.categoryIndex, this.expenseList, this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    var isDark = _theme.getTheme() == _theme.dark;
    final provider = Provider.of<Expenses>(context, listen: false);
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.8,
      child: SimpleDialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        title: Text(
          S.of(context).DialogExpenseIncome,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, height: 3, letterSpacing: 1.0),
        ),
        children: [
          Container(
            height: 400,
            width: 400,
            child: ListView.builder(
            itemCount: expenseList.length,
            itemBuilder: (context, index) {
              var thisExpense = expenseList[index];
              return Dismissible(
                key: UniqueKey(),
                child: Column(
                  children: [
                    ExpenseItem(
                      expense: thisExpense,
                      currency: currency,
                    ),
                    Divider(
                      height: 25,
                      color: isDark
                          ? Color.fromRGBO(1223, 81, 83, 1)
                          : Colors.black,
                    ),
                  ],
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  return provider.delete(thisExpense.id);
                },
                background: DismissibleBackground(),
              );
            },
        ),
          )],
      ),
    );
  }
}