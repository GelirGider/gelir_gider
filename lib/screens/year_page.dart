import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/components/divider.dart';
import 'package:gelir_gider/widgets/dialogs/main_page_category_modal.dart';
import 'package:gelir_gider/widgets/year_page/month_item.dart';
import 'package:gelir_gider/widgets/year_page/week_item.dart';
import 'package:gelir_gider/widgets/year_page/day_item.dart';
import 'package:gelir_gider/widgets/year_page/year_item.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/widgets/components/money_widget.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:gelir_gider/providers/providers.dart';

// TabBar da 4. kısımda bulunan Yıl ekranının tasarımı ve tüm arkaplanının
// bulunduğu kısım

class YearPage extends StatefulWidget {
  @override
  _YearPageState createState() => _YearPageState();
}

class _YearPageState extends State<YearPage>
    with SingleTickerProviderStateMixin{

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    var isDark = _theme.getTheme() == _theme.dark;
    final size = MediaQuery.of(context).size;

    final monthNames = <String>[
      S.of(context).January,
      S.of(context).February,
      S.of(context).March,
      S.of(context).April,
      S.of(context).May,
      S.of(context).June,
      S.of(context).July,
      S.of(context).August,
      S.of(context).September,
      S.of(context).October,
      S.of(context).November,
      S.of(context).December,
    ];
    return Consumer<Expenses>(
      child: null,
      builder: (context, provider, child) {
        switch (provider.selectedPage) {
          case 0:
            var myList = provider.expense;
            var list = provider.getCurrentYears();
            return Container(
              padding: EdgeInsets.fromLTRB(0,0.015*size.height,0,0),
              child: Column(
                children: [
                  MoneyWidget(myList),
                  SizedBox(height: size.height * 0.01),
                  Divider(thickness: 1.7*MediaQuery.of(context).textScaleFactor,color:Colours.getBlackOrWhite(isDark)),
                  SizedBox(height: size.height * 0.01),
                  Flexible(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        provider.getSymbol();
                        var years = list.elementAt(index);
                        return Column(
                          children: [
                            Container(
                              padding:EdgeInsets.symmetric(),
                              child: YearListItem(
                                year: years,
                              ),
                            ),
                          ],
                        );
                      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3),
                    ),
                  )
                ],
              ),
            );
            break;
          case 1:
            var myList = provider.currentYear[provider.selectedYear];
            final list = provider.getCurrentMonths();
            return Container(
              padding: EdgeInsets.fromLTRB(0,0.015*size.height,0,0),
              child: Column(
                children: [
                  MoneyWidget(myList),
                  SizedBox(height: size.height * 0.01),
                  Divider(thickness: 1.7*MediaQuery.of(context).textScaleFactor,color:Colours.getBlackOrWhite(isDark)),
                  SizedBox(height: size.height * 0.01),
                  Flexible(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        provider.getSymbol();
                        var months = list.elementAt(index);
                        return Column(
                          children: [
                            Container(
                              padding:EdgeInsets.symmetric(),
                              child: MonthListItem(
                                title: monthNames[months - 1],
                                index: months - 1,
                              ),
                            ),

                          ],
                        );
                      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3),
                    ),
                  )
                ],
              ),
            );
            break;
          case 2:
            var myList = provider.currentMonth[provider.selectedMonth + 1];
            var weekButtons = <WeekItem>[];
            final lastDay = provider.getLastDayOfMonth();
            var weekDays = ['1-7', '8-14', '15-21', '22-' + lastDay.toString()];
            weekDays.forEach((weekText) {
              var startDay = int.parse(weekText.split('-')[0]);
              var endDay = int.parse(weekText.split('-')[1]);
              if (!provider.checkWeekNull(startDay, endDay)) {
                weekButtons.add(WeekItem(
                  title: weekText + ' ' + monthNames[provider.selectedMonth],
                ));
              }
            });
            return Container(
              padding: EdgeInsets.fromLTRB(0,0.015*size.height,0,0),
              child: Column(
                children: [
                  MoneyWidget(myList),
                  SizedBox(height: size.height * 0.01),
                  Divider(thickness: 1.7*MediaQuery.of(context).textScaleFactor,color:Colours.getBlackOrWhite(isDark)),
                  SizedBox(height: size.height * 0.01),
                  Flexible(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: weekButtons.length,
                      itemBuilder: (context, index) {
                        var weekButton = weekButtons[index];
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(),
                              child: Column(
                                children: [
                                  weekButton,
                                ],
                              )
                            ),
                          ],
                        );
                      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3),
                    ),
                  )
                ],
              ),
            );
            break;

          case 3:
            var daysAndMonth = provider.selectedWeek;
            var days = daysAndMonth.split(' ')[0];
            var  startDay = int.parse(days.split('-')[0]);
            var endDay = int.parse(days.split('-')[1]);
            var monthName = daysAndMonth.split(' ')[1];

            var dayButtons = <DayListItem>[];
            var curDays = provider.getCurrentDays(startDay, endDay);
            print(curDays.toString());
            var myList=<Expense>[];
            curDays.forEach((element) {
              if (element != null) {
                myList = myList+provider.currentDay[element];
                dayButtons.add(DayListItem(
                  title: element.toString() + ' ' + monthName,
                ));
              }
            });
            return Container(
              padding: EdgeInsets.fromLTRB(0,0.015*size.height,0,0),
              child: Column(
                children: [
                  MoneyWidget(myList),
                  SizedBox(height: size.height * 0.01),
                  Divider(thickness: 1.7*MediaQuery.of(context).textScaleFactor,color:Colours.getBlackOrWhite(isDark)),
                  SizedBox(height: size.height * 0.01),
                  Flexible(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: dayButtons.length,
                      itemBuilder: (context, index) {
                        var dayItem = dayButtons[index];
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(),
                              child: Column(
                                children: [
                                  dayItem,
                                ],
                              ),
                            ),
                          ],
                        );
                      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3),
                    ),
                  )
                ],
              ),
            );
            break;
          case 4:
            var res = provider.currentDay[provider.selectedDay];
            var myList = provider.groupExpensesByCategories(res);
            return FutureBuilder(
                future: Provider.of<Expenses>(context, listen: false)
                    .fetchAndSetExpenses(),
                builder: (ctx, snapshot) => Container(
              padding: EdgeInsets.fromLTRB(0,0.015*size.height,0,0),
              child: Column(
                children: [
                  MoneyWidget(res),
                  SizedBox(height: size.height * 0.01),
                  Divider(thickness: 1.7*MediaQuery.of(context).textScaleFactor,color:Colours.getBlackOrWhite(isDark)),
                  SizedBox(height: size.height * 0.01),
                  Flexible(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
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
