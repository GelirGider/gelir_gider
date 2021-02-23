import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/main_drawer.dart';
import 'package:gelir_gider/widgets/save_button.dart';
import 'package:jiffy/jiffy.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:gelir_gider/screens/category_screen.dart';
import 'package:gelir_gider/providers/theme_provider.dart';

class AddingExpense extends StatefulWidget {
  final scaffoldKey;
  const AddingExpense({Key key, this.scaffoldKey}) : super(key: key);
  @override
  _AddingExpenseState createState() => _AddingExpenseState();
}

class _AddingExpenseState extends State<AddingExpense> with TickerProviderStateMixin {
  static final _form = GlobalKey<FormState>();
  var _isLoading = false;
  String description = '';
  double price = 0.0;
  String time = '';
  bool isExpense = false;
  var category;
  var id;
  TabController _tabController;


  @override
  void initState() {
    _tabController=TabController(length:2,vsync :this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void moveToSecondPage() async {
    id = await Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => CategoryScreen(),
          ),
        ) ??
        0;
    setState(() {
      Provider.of<Expenses>(context, listen: false).setCurrentCategory(id);
    });
    print('id:::::::::::::::::::::$id');
  }

  Future<void> _saveForm(scaffoldKey, snackBar) async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    print('isExpense :::::::::::::::::$isExpense');

    await Provider.of<Expenses>(context, listen: false).addExpense(
      Expense(
        id: UniqueKey().toString(),
        category: id ?? 0,
        isExpense: isExpense ? 'expense' : 'income',
        time: time,
        price: isExpense ? (price*(-1)) : price,
        description: description,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => scaffoldKey.currentState.showSnackBar(snackBar),
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
    category = Provider.of<Expenses>(context, listen: false).CurrentCategory;
    print(category.categoryName);
    final snackBar = SnackBar(
      content: Container(
        child: Text(
          'İşlem eklendi',
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.overline.color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.purple,
    );
    return SafeArea(
      child: Scaffold(
        endDrawer : MainDrawer(),
        appBar: GradientAppBar(
          gradient: LinearGradient(
              colors: _theme.getTheme() == _theme.dark
                  ? [Color(0xff212121), Color(0xff212121)]
                  : [Color.fromRGBO(227, 9, 23, 1), Color.fromRGBO(94, 23, 235, 1)]),
          centerTitle: true,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                      child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            FittedBox(
                              child: Center(child: TabBar(

                                controller: _tabController,
                                
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    25.0,
                                  ),
                                  color: Colors.green,
                                ),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Tab(
                                    text: 'Expense',
                                  ),


                                  Tab(
                                    text: 'Income',
                                  ),

                                ],),

                               /* child: LiteRollingSwitch(
                                  value: isExpense,
                                  textOff: S.of(context).AddingScreenIncome,
                                  textOn: S.of(context).AddingScreenExpense,
                                  colorOn: Colors.red,
                                  colorOff: Colors.green,
                                  iconOn: Icons.remove,
                                  iconOff: Icons.add,
                                  textSize: 15,
                                  onChanged: (bool value) {
                                    isExpense = value;
                                  },
                                ),*/

                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                moveToSecondPage();
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: _theme.getTheme() == _theme.dark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                width: 500.0,
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(50, 10, 30, 10),
                                child: ListTile(
                                  leading: category.categoryImg,
                                  title: Text(
                                    category.categoryName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
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
                              height: 35.0,
                            ),
                            SaveButton(
                              onPressed: () =>
                                  _saveForm(widget.scaffoldKey, snackBar),
                            ),
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
