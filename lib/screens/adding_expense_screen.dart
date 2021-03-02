import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/components/main_drawer.dart';
import 'package:gelir_gider/widgets/buttons/save_button.dart';
import 'package:jiffy/jiffy.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:gelir_gider/screens/category_screen.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:gelir_gider/themes/colours.dart';

class AddingExpense extends StatefulWidget {
  final scaffoldKey;
  const AddingExpense({Key key, this.scaffoldKey}) : super(key: key);
  @override
  _AddingExpenseState createState() => _AddingExpenseState();
}

class _AddingExpenseState extends State<AddingExpense>
    with TickerProviderStateMixin {
  static final _form = GlobalKey<FormState>();
  var _isLoading = false;
  String description = '';
  double price = 0.0;
  String time = '';
  bool isExpense = false;
  var category;
  var id;

  void moveToSecondPage() async {
    id = await Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => CategoryScreen(),
          ),
        ) ??
        Provider.of<Expenses>(context, listen: false).currentCategoryId;
    Provider.of<Expenses>(context, listen: false).setCurrentCategory(id);
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Expenses>(context, listen: false).addExpense(
      Expense(
        id: UniqueKey().toString(),
        category: id ?? 0,
        isExpense: isExpense ? 'expense' : 'income',
        time: time,
        price: isExpense ? (price * (-1)) : price,
        description: description,
      ),
    );
    await Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      category = Provider.of<Expenses>(context, listen: false).CurrentCategory;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    var isDark = _theme.getTheme() == _theme.dark;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    category = Provider.of<Expenses>(context, listen: false).CurrentCategory;

    return SafeArea(
      child: Scaffold(
        endDrawer: MainDrawer(),
        appBar: GradientAppBar(
          gradient: LinearGradient(colors: Colours.getGradientColors(isDark)),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  size: 30.0,
                ),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,

                ///it opens a drawer
              ),
            ),
          ],
          title: Icon(Icons.attach_money),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: ToggleSwitch(
                        minWidth: 120.0,
                        minHeight: 60.0,
                        fontSize: 17.0 * textScaleFactor,
                        initialLabelIndex: 0,
                        cornerRadius: 60.0,
                        activeBgColor: Colours.activeBgColor,
                        activeFgColor: Colours.white,
                        inactiveBgColor: Colours.inactiveBgColor,
                        inactiveFgColor: Colours.black,
                        labels: [
                          S.of(context).AddingScreenIncome,
                          S.of(context).AddingScreenExpense,
                        ],
                        onToggle: (index) {
                          if (index == 0) {
                            isExpense = false;
                          }
                          if (index == 1) {
                            isExpense = true;
                          }
                          print('switched to: $index');
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                moveToSecondPage();
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Colours.getBlackOrWhite(isDark)),
                                ),
                                width: 500.0,
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(50, 10, 30, 10),
                                child: ListTile(
                                  leading: category.categoryImg,
                                  title: Text(
                                    category.categoryName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 19.0 * textScaleFactor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  labelText:
                                      S.of(context).AddingScreenDescription),
                              onSaved: (newValue) {
                                description = newValue;
                              },
                            ),
                            Divider(
                              height: 30,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: S.of(context).AddingScreenPrice,
                              ),
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Bir fiyat ekleyin';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Bir sayı yazın';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                price = double.parse(newValue);
                              },
                            ),
                            Divider(
                              height: 30,
                            ),
                            Center(
                              child: DateTimePicker(
                                textAlign: TextAlign.center,
                                initialValue: DateTime.now().toString(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                dateLabelText: S.of(context).AddingScreenDate,
                                onChanged: (val) => time = val,
                                validator: (val) {
                                  print(val);
                                  return null;
                                },
                                onSaved: (val) {
                                  val = Jiffy(val).format('yyyy-MM-dd');
                                  time = val;
                                },
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 30.0,
                            ),
                            SaveButton(
                              onPressed: () => _saveForm(),
                            ),
                            SizedBox(
                              height: 15.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
