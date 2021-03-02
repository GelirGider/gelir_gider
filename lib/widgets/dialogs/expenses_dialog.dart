import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/components/expense_item.dart';
import 'package:gelir_gider/themes/colours.dart';

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
        children: expenseList
            .map(
              (e) => Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Divider(
                      height: 25,
                      color: Colours.getBlackOrWhite(isDark),
                    ),
                    ExpenseItem(
                      expense: e,
                      currency: currency,
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
