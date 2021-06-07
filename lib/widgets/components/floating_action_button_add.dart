import 'package:flutter/material.dart';
import 'package:gelir_gider/screens/adding_expense_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:gelir_gider/generated/l10n.dart';

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
      heroTag: "floatingbutton",
      icon: Icons.add,
      iconTheme: IconThemeData(size: 30,color: Colours.white),
      activeIcon: Icons.close,
      curve: Curves.bounceIn,
      renderOverlay: false,
      overlayColor: Colors.black,
      overlayOpacity: 0.2,
      buttonSize: 60.0,
      gradientBoxShape: BoxShape.circle,
      gradient: LinearGradient(colors: Colours.getGradientColors(false)),
      children: [
        SpeedDialChild(
          child: Icon(Icons.remove),
          foregroundColor: Colours.white,
          backgroundColor: Colours.red,
          labelStyle: TextStyle(color: Colours.black),
          label: S.of(context).AddingScreenExpense,
          onTap: () => navigationFunction(context, scaffoldKey,true),
        ),
        SpeedDialChild(
          child: Icon(Icons.add),
          foregroundColor: Colours.white,
          backgroundColor: Colours.green,
          label: S.of(context).AddingScreenIncome,
          labelStyle: TextStyle(color: Colours.black),
          onTap: () => navigationFunction(context, scaffoldKey,false),
        ),
      ],
    );
  }
}
