import 'package:flutter/material.dart';
import 'package:gelir_gider/main.dart';
import 'package:gelir_gider/screens/adding_expense_screen.dart';
import 'package:gelir_gider/widgets/buttons/add_button.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:gelir_gider/themes/colours.dart';
class FloatingActionButtonAdd extends StatelessWidget {

  // Sağ altta ekleme ekranına götüren + ikonlu butonumuzun
  // Navigation işlemi ile diğer sayfaya gitmesini sağladığımız kısım
  final context;
  final scaffoldKey;

  const FloatingActionButtonAdd({Key key, this.context, this.scaffoldKey})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<void> navigationFunction(context, scaffoldKey, isExpense) {
      return Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => AddingExpense(
          scaffoldKey: scaffoldKey,
          isExpense : isExpense
        ),
      ));
    }

    return SpeedDial(
      child : AddButton(),
      labelsStyle: TextStyle(color: Colours.black),
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
          child: Icon(Icons.add),
          foregroundColor: Colours.white,
          backgroundColor: Colours.green,
          label: 'Gelir',
          onPressed: () => navigationFunction(context, scaffoldKey,false),
          closeSpeedDialOnPressed: false,
        ),
        SpeedDialChild(
          child: Icon(Icons.remove),
          foregroundColor: Colours.white,
          backgroundColor: Colours.red,
          label: 'Gider',
          onPressed: () => navigationFunction(context, scaffoldKey,true),
        ),
      ],
    );
  }
}
