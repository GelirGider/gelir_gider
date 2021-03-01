import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/widgets/year_page/year_item.dart';
import 'package:gelir_gider/providers/expense_provider.dart';

class YearListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var expenseProvider = Provider.of<Expenses>(context);
    var yearList = expenseProvider.getCurrentYears();

    var yearButtons = <YearListItem>[];
    yearList.forEach((element) {
      yearButtons.add(YearListItem(
        year: element,
      ));
    });
    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20.0,
      childAspectRatio: 1.0,
      padding: EdgeInsets.all(30.0),
      crossAxisCount: 3,
      children: yearButtons,
    );
  }
}
