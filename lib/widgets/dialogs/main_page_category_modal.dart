import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/widgets/dialogs/expenses_dialog.dart';
import 'package:gelir_gider/themes/colours.dart';

class MainPageCategoryModal extends StatelessWidget {

  // Ana ekranda harcamaları mevcut olan kategorilerin oluşturulduğu kısım

  final int category;
  final List<Expense> list;
  final String currency;
  const MainPageCategoryModal(
      {Key key, this.category, this.list, this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    var provider = Provider.of<Expenses>(context, listen: false);
    void showExpensesDialog() {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return ExpensesDialogWidget(
              currency: currency, categoryIndex: category, expenseList: list);
        },
      );
    }

    return ListTile(
      onTap: () {
        return showExpensesDialog();
      },
      leading: FittedBox(
        fit: BoxFit.cover,
        child: CircleAvatar(
          child: provider.isPersonal
              ? provider.imgList[category]
              : provider.imgListCorporate[category],
          backgroundColor: Colours.white,
          radius: 25,
        ),
      ),
      title: Text(
        provider.isPersonal
            ? provider.categories[category].categoryName
            : provider.corporateCategories[category].categoryName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: checkTotalPrice(calculatePrice(), currency, textScaleFactor),
    );
  }

  Widget checkTotalPrice(double price, String currency, double scaleFactor) {
    if (price < 0) {
      return Text(
        price.toStringAsFixed(1) + ' ' + currency,
        style: TextStyle(color: Colours.red, fontSize: 15 * scaleFactor),
      );
    } else {
      return Text(
        '+ ' + price.toStringAsFixed(1) + ' ' + currency,
        style: TextStyle(color: Colours.green, fontSize: 15 * scaleFactor),
      );
    }
  }

  double calculatePrice() {
    var total = 0.0;
    list.forEach((element) {
      total += element.price;
    });
    return total;
  }
}
