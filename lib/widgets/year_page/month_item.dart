import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:provider/provider.dart';

class MonthListItem extends StatelessWidget {

  // Yıl kısmında ay kısmına geldiğimizde gözüken butonların tasarımı ve
  // tıklandığında yapılacak işlemlerin bulunduğu kısım

  final String title;
  final int index;

  const MonthListItem({Key key, this.title, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<Expenses>(context, listen: false);
    return TextButton(
      style : TextButton.styleFrom(shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 15),
        backgroundColor: Colours.pink,),
      onPressed: () {
        expenseProvider.setSelectedMonth(index);
        expenseProvider.setSelectedPage(2);
      },

      child: Text(
        title,
        style: TextStyle(
          color: Colours.white,
        ),
      ),
    );
  }
}
