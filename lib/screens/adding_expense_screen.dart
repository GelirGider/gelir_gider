import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:gelir_gider/screens/category_screen.dart';
import 'package:gelir_gider/widgets/category_item.dart';
import 'package:gelir_gider/modals/custom_theme_modal.dart';


class AddingExpense extends StatefulWidget {
  final scaffoldKey;

  const AddingExpense({Key key, this.scaffoldKey}) : super(key: key);
  @override
  _AddingExpenseState createState() => _AddingExpenseState();
}

class _AddingExpenseState extends State<AddingExpense> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;

  String description = '';
  double price = 0.0;
  CategoryItem category =CategoryItem(Image.asset('assets/categories/bill.png'),'Ödeme',0);
  String time = '';
  bool isExpense = true;

  void moveToSecondPage() async {
    category = await Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true, builder: (context) => CategoryScreen())
    )??category;
    updateInformation(category);
  }

  void updateInformation(CategoryItem category) {
    setState(() => category = category);
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

    await Provider.of<Expenses>(context, listen: false).addExpense(
      Expense(
        id: UniqueKey().toString(),
        category: category,
        isExpense: isExpense ? 'expense' : 'income',
        time: time,
        price: price,
        description: description,
      ),
    );
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
    await Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<CustomThemeModal>(context, listen: false);
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
        appBar: GradientAppBar(
          gradient: LinearGradient(colors: _theme.getThemeData.brightness == Brightness.dark
              ? [Color(0xff212121), Color(0xff212121)]
              : [Colors.purple, Colors.pink]),
          centerTitle: true,
          title: Icon(Icons.attach_money),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveForm(widget.scaffoldKey, snackBar);
              },
            ),
          ],
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
                            Center(
                              child: LiteRollingSwitch(
                                value: isExpense,
                                textOn: 'Gelir',
                                textOff: 'Gider',
                                colorOn: Colors.green,
                                colorOff: Colors.red,
                                iconOn: Icons.add,
                                iconOff: Icons.remove,
                                textSize: 15,
                                onChanged: (bool value) {
                                  isExpense = value;
                                },
                              ),
                            ),
                        GestureDetector(
                            onTap: (){
                              moveToSecondPage();
                            },
                            child:  Container(
                              margin: EdgeInsets.fromLTRB(0,20,0,20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: _theme.getThemeData.brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              width: 500.0,
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(50, 10, 30, 10),
                              child:  ListTile(
                                leading: category.categoryImg,
                                title: Text(category.categoryName,textAlign: TextAlign.center,style: TextStyle(),),
                              ),
                            )
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              decoration:
                                  InputDecoration(labelText: 'Açıklama'),
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
                                labelText: 'Fiyatı',
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
                                locale: const Locale('tr', 'TR'),
                                textAlign: TextAlign.center,
                                initialValue: DateTime.now().toString(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                dateLabelText: 'Tarih',
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
