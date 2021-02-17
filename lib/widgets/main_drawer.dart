import 'package:flutter/material.dart';
import 'package:gelir_gider/screens/expenses_list_screen.dart';
import 'package:gelir_gider/screens/language_selection_screen.dart';
import 'package:gelir_gider/widgets/theme_dialog_widget.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void showThemePicker() {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return ThemeDialogWidget();
        },
      );
    }

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text('Gelir Gider'),
          ),
          ListTile(
            onTap: () {
              return Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => ExpensesListScreen(),
                ),
              );
            },
            trailing: Icon(
              Icons.list,
              color: Theme.of(context).buttonColor,
            ),
            leading: Text('Expenses List'),
          ),
          ListTile(
            onTap: () {
              showThemePicker();
            },
            trailing: Icon(
              Icons.color_lens,
              color: Theme.of(context).buttonColor,
            ),
            leading: Text('select Theme'),
          ),
          ListTile(
            onTap: () {
              return Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => LanguageSelectionScreen(),
                ),
              );
            },
            trailing: Icon(
              Icons.language,
              color: Theme.of(context).buttonColor,
            ),
            leading: Text('select Language'),
          ),
        ],
      ),
    );
  }
}
