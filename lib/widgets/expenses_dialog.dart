import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/expense_item.dart';

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

    return Container(
      height: 400,
      width: 400,
      child: SimpleDialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        title: Text(
          S.of(context).DialogExpenseIncome,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, height: 2.5, letterSpacing: 1.0),
        ),
        children: expenseList
            .map(
              (e) => Container(
                child: Column(
                  children: [
                    ExpenseItem(
                      expense: e,
                      currency: currency,
                    ),
                    Divider(
                      height: 25,
                      color: _theme.getTheme() == _theme.dark
                          ? Color.fromRGBO(223, 81, 83, 1)
                          : Colors.black,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
