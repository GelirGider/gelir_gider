import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:provider/provider.dart';

class MoneyWidget extends StatelessWidget {
  final String income;
  final String money;
  final String expense;

  const MoneyWidget({Key key, this.income, this.money, this.expense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final langState = Provider.of<LanguageHandler>(context, listen: false);
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                langState.isEnglish ? 'Total Income' : 'Toplam Gelir',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                income,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                langState.isEnglish ? 'Total Money' : 'Ana Para',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                money,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                langState.isEnglish ? 'Total Expense' : 'Toplam Gider',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                expense,
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
    );
  }
}
