import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:gelir_gider/screens/expenses_list_screen.dart';


class MonthList extends StatefulWidget {
  @override
  _MonthListState createState() => _MonthListState();
}


List iconsMonth = [
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colors.pink,
    child: Text(
      'January',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colors.pink,
    child: Text(
      'February',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colors.pink,
    child: Text(
      'March',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colors.pink,
    child: Text(
      'April',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colors.pink,
    child: Text(
      'May',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colors.pink,
    child: Text(
      'June',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colors.pink,
    child: Text(
      'July',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colors.pink,
    child: Text(
      'August',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colors.pink,
    child: Text(
      'September',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colors.pink,
    child: Text(
      'October',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colors.pink,
    child: Text(
      'November',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  FlatButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    color: Colors.pink,
    child: Text(
      'December',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
];



class _MonthListState extends State<MonthList> {
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: GridView.count(
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1.0,
        padding: EdgeInsets.all(10.0),
        crossAxisCount: 3,
        children: List.generate(
          iconsMonth.length,
              (index) {
            return FlatButton(
              onPressed: () {},
              child: iconsMonth[index],
            );
          },
        ),
      ),
    );



  }
}
