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

  double calculate(list) {
    var sum = 0.0;
    list.forEach((element) {
      sum += element.price;
    });
    return sum;
  }

  Widget _buildBody(title, sum, onPressed, page) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlatButton.icon(
          onPressed: onPressed,
          icon: Icon(Icons.arrow_back),
          label: Text(title),
        ),
        Container(
          child: Text(sum.toStringAsFixed(1)),
        ),
        page,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Expenses>(
      child: null,
      builder: (context, provider, child) {
        if (provider.selectedPage == 0) {
          var list = provider.expense;
          var sum = calculate(list);
          return _buildBody('title', sum, null, YearListPage());
        }
        if (provider.selectedPage == 1) {
          var list = provider.getYearList(provider.selectedYear);
          var sum = calculate(list);
          return _buildBody(
              'title', sum, () => provider.setSelectedPage(0), MonthListPage());
        }
        if (provider.selectedPage == 2) {
          var list = provider.getYearList(provider.selectedYear);
          var sum = calculate(list);
          return _buildBody(
              'title', sum, () => provider.setSelectedPage(1), WeekListPage());
        }
        if (provider.selectedPage == 3) {
          var list = provider.getYearList(provider.selectedYear);
          var sum = calculate(list);
          return _buildBody(
              'title', sum, () => provider.setSelectedPage(2), DayListPage());
        } else if (provider.selectedPage == 4) {
          print(provider.selectedPage);
          var res = provider.currentMap[provider.selectedDay];
          var myList = provider.groupExpensesByCategories(res);
          print(myList.length);
          return Container(
            height: 400,
            child: ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, index) {
                provider.getSymbol();
                var category = 0; //myList[index].category;
                var list = myList;
                var currency = provider.symbol;
                print(
                    'selectedDay:${provider.selectedDay}selectedMonth:${provider.selectedMonth}selectedYear:${provider.selectedYear}');
                return Column(
                  children: [
                    MainPageCategoryModal(
                      category: category,
                      list: [],
                      currency: currency,
                    ),
                    OurDivider(),
                  ],
                );
              },
            ),
          );
        } else {
          return Container(
            child: Text('ASDASDASDASDASDASD'),
          );
        }
      },
    );
  }
}
