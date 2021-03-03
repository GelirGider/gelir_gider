import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/components/divider.dart';
import 'package:gelir_gider/widgets/dialogs/main_page_category_modal.dart';
import 'package:gelir_gider/widgets/year_page/month_list_page.dart';
import 'package:gelir_gider/widgets/year_page/day_list_page.dart';
import 'package:gelir_gider/widgets/year_page/week_list_page.dart';
import 'package:gelir_gider/widgets/year_page/year_list_page.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/widgets/components/money_widget.dart';

class YearPage extends StatefulWidget {
  @override
  _YearPageState createState() => _YearPageState();
}

class _YearPageState extends State<YearPage> {
  bool init = true;

  @override
  void didChangeDependencies() {
    if (init) {
      Provider.of<Expenses>(context, listen: false).setSelectedPage(0);
      init = false;
    }
    super.didChangeDependencies();
  }

  Widget _buildBody(title, Map<int, List<Expense>> list, onPressed, page) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlatButton.icon(
            onPressed: onPressed,
            icon: SizedBox(
              width: 18.0,
              child: Icon(
                Icons.arrow_left_outlined,
                size: 35.0,
                color: Colors.black87,
              ),
            ),
            label: Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 17.0,
                wordSpacing: 0.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Container(
            child: MoneyWidget(list),
          ),
          page,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Expenses>(
      child: null,
      builder: (context, provider, child) {
        switch (provider.selectedPage) {
          case 0:
            var list = provider.groupExpensesByCategories(provider.expense);
            return _buildBody('Back', list, null, YearListPage());
            break;
          case 1:
            var list = provider.getCurrentYears();
            return _buildBody('Back', provider.currentYear, () async {
              provider.setSelectedPage(0);
              await provider.getCurrentYears();
            }, MonthListPage());
            break;
          case 2:
            return _buildBody('Back', provider.currentMonth, () {
              provider.setSelectedPage(1);
              provider.getCurrentMonths();
            }, WeekListPage());
            break;
          case 3:
            return _buildBody('Back', provider.currentWeek, () {
              provider.setSelectedPage(2);
              provider.getCurrentDays(
                  int.parse(provider.selectedWeek.split('-')[0]),
                  int.parse(provider.selectedWeek.split('-')[1]));
            }, DayListPage());
            break;
          case 4:
            var res = provider.currentWeek[provider.selectedDay];
            var myList = provider.groupExpensesByCategories(res);
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  MoneyWidget(myList),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: myList.keys.length,
                      itemBuilder: (context, index) {
                        provider.getSymbol();
                        var category = myList.keys.toList()[index];
                        var list = myList.values.toList()[index];
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
                  )
                ],
              ),
            );
            break;
          default:
            return Container();
        }
      },
    );
  }
}
