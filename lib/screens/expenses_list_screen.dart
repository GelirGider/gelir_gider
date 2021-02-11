import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:gelir_gider/widgets/expense_item.dart';
import 'package:provider/provider.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:theme_manager/change_theme_widget.dart';

import 'adding_expense_screen.dart';

class ExpensesListScreen extends StatefulWidget {
  @override
  _ExpensesListScreenState createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends State<ExpensesListScreen> {
  void setAsSystemDefault() => ThemeManager.of(context)
      .setBrightnessPreference(BrightnessPreference.system);
  void setAsLight() => ThemeManager.of(context)
      .setBrightnessPreference(BrightnessPreference.light);
  void setAsDark() => ThemeManager.of(context)
      .setBrightnessPreference(BrightnessPreference.dark);
  void showThemePicker() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ThemePickerDialog(
          onSelectedTheme: (BrightnessPreference preference) {
            ThemeManager.of(context).setBrightnessPreference(preference);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final langState = Provider.of<LanguageHandler>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(langState.isEnglish ? 'Add/Remove' : 'Ekle/Çıkar'),
          actions: [
            FlatButton(
              onPressed: showThemePicker,
              child: Icon(Icons.color_lens),
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<Expenses>(context, listen: false)
              .fetchAndSetExpenses(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Expenses>(
                  child: Center(
                    child: const Text('Got no places yet, start adding some!'),
                  ),
                  builder: (ctx, expenseProvider, ch) => expenseProvider
                          .expense.isEmpty
                      ? ch
                      : LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Column(
                              children: [
                                Container(
                                  height: constraints.maxHeight,
                                  child: ListView.builder(
                                    itemCount: expenseProvider.expense.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          ExpenseItem(
                                            expense:
                                                expenseProvider.expense[index],
                                          ),
                                          Divider(),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddingExpense())),
          child: Icon(Icons.post_add_rounded, color: Colors.white),
        ),
      ),
    );
  }
}
