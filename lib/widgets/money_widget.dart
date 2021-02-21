import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MoneyWidget extends StatelessWidget {
  var income;
  var money;
  var expense;
  var percentage;

  MoneyWidget({Key key, this.income, this.money, this.expense, this.percentage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
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
        SizedBox(
          width: 5,
        ),
        CircularPercentIndicator(
          radius: 150.0,
          animation: true,
          animationDuration: 750,
          reverse: true,
          lineWidth: 20.0,
          percent: percentage,
          center: Text(
            money,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: Colors.red,
          progressColor: Colors.green,
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
