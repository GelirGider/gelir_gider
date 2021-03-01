import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer<Expenses>(
      child: null,
      builder: (context, provider, child) {
        if (provider.selectedPage == 0) {
          return YearListPage();
        }
        if (provider.selectedPage == 1) {
          return MonthListPage();
        }
        if (provider.selectedPage == 2) {
          return WeekListPage();
        }
        if (provider.selectedPage == 3) {
          return DayListPage();
        }
        else {
          return Container();
        }
      },
    );
  }
}
