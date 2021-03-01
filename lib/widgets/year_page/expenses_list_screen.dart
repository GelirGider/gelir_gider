import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/expense_provider.dart';

class ExpensesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Expenses>(context, listen: false);
    final year = provider.selectedYear;
    final month = provider.selectedMonth;
    final day = provider.selectedDay;

    final date = DateTime.parse(year.toString() +
        '-' +
        provider.fixAsDate(month).toString() +
        '-' +
        provider.fixAsDate(day).toString());


    return Container();
    /*Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        MoneyWidget(
          income: provider.calculateTotalIncome().toStringAsFixed(1),
          money: provider.calculateTotalMoney().toStringAsFixed(1),
          expense: provider.calculateTotalExpense().toStringAsFixed(1),
          percentage: provider.getPercentage,
        ),
        OurDivider(),
        Flexible(
          flex: 10,
          child: ListView.builder(
            itemCount: provider.currentItems.length,
            itemBuilder: (context, index) {
              provider.getSymbol();
              var category = provider.currentItems.keys.toList()[index];
              var list = provider.currentItems.values.toList()[index];
              var currency = provider.symbol;
              return Column(
                children: [
                  MainPageCategoryModal(
                    category: category,
                    list: list,
                    currency: currency,
                  ),
                  OurDivider(),
                ],
              );
            },
          ),
        ),
        BottomSpace(),
      ],
    );*/
  }
}
