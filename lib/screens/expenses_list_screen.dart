import 'dart:ui';
import 'package:gelir_gider/screens/year_page.dart';
import 'package:gelir_gider/widgets.dart';
import 'package:gelir_gider/providers/providers.dart';

import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';

import 'package:gelir_gider/themes/colours.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesListScreen extends StatefulWidget {
  @override
  _ExpensesListScreenState createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends State<ExpensesListScreen> {
  var languageIndex;

  Future<String> _getPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    languageIndex = prefs.getInt('language') ?? 0;
    Provider.of<Languages>(context, listen: false).setLanguage(languageIndex);
    return 'Başarılı';
  }

  @override
  void initState() {
    _getPrefs().then((value) => {});
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Expenses>(context, listen: false).setCategories(context);
      return Provider.of<Expenses>(context, listen: false).setTabBarIndex(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    var isDark = _theme.getTheme() == _theme.dark;

    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          endDrawer: MainDrawer(),
          key: scaffoldKey,
          appBar: GradientAppBar(
            leading: AccountChanger(),
            centerTitle: true,
            actions: [DrawerButton(scaffoldKey: scaffoldKey)],
            title: Icon(Icons.attach_money),
            gradient: LinearGradient(
              colors: Colours.getGradientColors(isDark),
            ),
            bottom: TabBar(
              onTap: (index) {
                Provider.of<Expenses>(context, listen: false)
                    .setTabBarIndex(index);
              },
              labelStyle: TextStyle(fontSize: 12),
              tabs: <Widget>[
                Tab(text: S.of(context).TabBarDay),
                Tab(text: S.of(context).TabBarWeek),
                Tab(text: S.of(context).TabBarMonth),
                Tab(text: S.of(context).TabBarYear),
              ],
            ),
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
                      child: Text(
                        S.of(context).ExpenseListNoneExpense,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    builder: (context, provider, child) {
                      return provider.TabBarIndex == 3
                          ? Container(
                              child: YearPage(),
                            )
                          : provider.currentItems.isEmpty
                              ? child
                              : Column(
                                  children: [
                                    SizedBox(height: size.height * 0.02),
                                    MoneyWidget(),
                                    OurDivider(),
                                    Flexible(
                                      flex: 10,
                                      child: ListView.builder(
                                        itemCount: provider.currentItems.length,
                                        itemBuilder: (context, index) {
                                          provider.getSymbol();
                                          var category = provider
                                              .currentItems.keys
                                              .toList()[index];
                                          var list = provider
                                              .currentItems.values
                                              .toList()[index];
                                          var currency = provider.symbol;
                                          return Column(
                                            children: [
                                              MainPageCategoryModal(
                                                category: category,
                                                list: list,
                                                currency: currency,
                                              ),
                                              OurDivider(),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    BottomSpace(),
                                  ],
                                );
                    },
                  ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButtonAdd(
            scaffoldKey: scaffoldKey,
            context: context,
          ),
        ),
      ),
    );
  }
}
