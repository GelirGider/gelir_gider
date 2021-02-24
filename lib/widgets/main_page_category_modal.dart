import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/widgets/expenses_dialog.dart';

class MainPageCategoryModal extends StatelessWidget{
  final int category;
  final List<Expense> list;
  const MainPageCategoryModal({Key key,this.category, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Expenses>(context);
    void showExpensesDialog() {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return ExpensesDialogWidget(category,list);
        },
      );
    }
    return ListTile(
      onTap: (){
        return showExpensesDialog();
      },
      leading: FittedBox(
        fit: BoxFit.cover,
        child: CircleAvatar(
          child: provider.imgList[category],
          backgroundColor: Colors.white,
          radius: 25,
        ),
      ),
      title: Text(provider.categories[category].categoryName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing:checkTotalPrice(calculatePrice())
    );
  }

  Widget checkTotalPrice(double price){
    if(price < 0){
      return Text(
        price.toStringAsFixed(1) + ' ₺',
        style: TextStyle(color: Colors.red, fontSize: 15),
      );
    }
    else{
      return Text(
        '+ ' + price.toStringAsFixed(1) + ' ₺',
        style: TextStyle(color: Colors.green, fontSize: 15),
      );
    }
  }

  double calculatePrice(){
    double total = 0;
    list.forEach((element) {
      total += element.price;
    });
    return total;
}
}