import 'dart:io';

import 'package:flutter/cupertino.dart';
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
              child: Icon(
                Icons.color_lens,
                color: Colors.white,
              ),
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
                    child: langState.isEnglish
                        ? const Text(
                            'Got no Expenses  yet \n Start adding some !')
                        : const Text(
                            'Henüz ekleme yapılmadı \n Eklemeye başlayın !'),
                  ),
                  builder: (ctx, expenseProvider, ch) => expenseProvider
                          .expense.isEmpty
                      ? ch
                      : LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Column(
                              children: [
                                Divider(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Toplam Gelir',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            expenseProvider
                                                .calculateTotalIncome()
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Ana Para',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            expenseProvider
                                                .calculateTotalMoney()
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Toplam Gider',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            expenseProvider
                                                .calculateTotalExpense()
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 25,
                                ),
                                Flexible(
                                  child: ListView.builder(
                                    itemCount: expenseProvider.expense.length,
                                    itemBuilder: (context, index) {
                                      var thisExpense =
                                          expenseProvider.expense[index];
                                      return Dismissible(
                                        key: UniqueKey(),
                                        child: Column(
                                          children: [
                                            ExpenseItem(
                                              expense: thisExpense,
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (direction) {
                                          setState(() {});
                                          return expenseProvider
                                              .delete(thisExpense.id);
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.delete,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
