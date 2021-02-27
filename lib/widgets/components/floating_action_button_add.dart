import 'package:flutter/material.dart';
import 'package:gelir_gider/screens/adding_expense_screen.dart';
import 'package:gelir_gider/widgets/buttons/add_button.dart';

class FloatingActionButtonAdd extends StatelessWidget {
  final context;
  final scaffoldKey;

  const FloatingActionButtonAdd({Key key, this.context, this.scaffoldKey})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<void> navigationFunction(context, scaffoldKey) {
      return Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => AddingExpense(
          scaffoldKey: scaffoldKey,
        ),
      ));
    }

    return FloatingActionButton(
      heroTag: 'btn1',
      onPressed: () => navigationFunction(context, scaffoldKey),
      child: AddButton(),
    );
  }
}
