import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:provider/provider.dart';

class DayListItem extends StatelessWidget {
  // Year kısmında gün kısmına eriştiğimizde gözüken butonların tasarımı ve
  // tıklandığında yapılacak işlemlerin bulunduğu kısım

  final String title;
  const DayListItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<Expenses>(context, listen: false);
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 15),
        backgroundColor: Colours.pink,
      ),
      onPressed: () {
        print(title.split(' ')[0]);
        expenseProvider.setSelectedDay(int.parse(title.split(' ')[0]));
        expenseProvider.setSelectedPage(4);
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
