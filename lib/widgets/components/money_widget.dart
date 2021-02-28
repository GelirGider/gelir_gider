import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:provider/provider.dart';

class MoneyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Consumer<Expenses>(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.01,
        ),
        builder: (context, provider, child) {
          return Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      S.of(context).MoneyWidgetIncome,
                      style: TextStyle(
                        fontSize: 18 * textScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      provider.calculateTotalIncome().toStringAsFixed(1),
                      style: TextStyle(
                          fontSize: 16 * textScaleFactor,
                          color: Colours.green,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              child,
              CircularPercentIndicator(
                radius: MediaQuery.of(context).size.height * 0.25,
                animation: true,
                animationDuration: 750,
                reverse: true,
                lineWidth: 20.0,
                percent: provider.getPercentage,
                center: Text(
                  provider.calculateTotalMoney().toStringAsFixed(1),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0 * textScaleFactor),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colours.red,
                progressColor: Colours.green,
              ),
              child,
              Expanded(
                child: Column(
                  children: [
                    Text(
                      S.of(context).MoneyWidgetExpense,
                      style: TextStyle(
                        fontSize: 18 * textScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      provider.calculateTotalExpense().toStringAsFixed(1),
                      style: TextStyle(
                          fontSize: 16 * textScaleFactor,
                          color: Colours.red,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
