import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

enum category {
  payment,
  food,
  clothes,
  shop,
  travel,
  education,
  entertainment,
  others,
}

class AddingExpense extends StatefulWidget {
  @override
  _AddingExpenseState createState() => _AddingExpenseState();
}

class _AddingExpenseState extends State<AddingExpense> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;

  String description = '';
  int price = 0;
  String category = 'payment';
  String time = '';
  bool isExpense = true;
  List<String> categoryList = [
    'payment',
    'food',
    'clothes',
    'shop',
    'travel',
    'education',
    'entertainment',
    'others'
  ];

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
        id: DateTime.now().toString(),
        category: category,
        isExpense: isExpense ? 'expense' : 'income',
        time: time,
        price: price,
        description: description,
      ),
    );
    await Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _langState = Provider.of<LanguageHandler>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              _langState.isEnglish ? 'Add Income/Expense' : 'Gelir/Gider Ekle'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveForm,
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
                                textOn:
                                    _langState.isEnglish ? 'Income' : 'Gelir',
                                textOff:
                                    _langState.isEnglish ? 'Expense' : 'Gider',
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
                            Divider(
                              height: 30,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: _langState.isEnglish
                                    ? 'Description'
                                    : 'Açıklama',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
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
                                labelText:
                                    _langState.isEnglish ? 'Price' : 'Fiyatı',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return _langState.isEnglish
                                      ? 'Please provide a price.'
                                      : 'Bir fiyat ekleyin';
                                }
                                if (double.tryParse(value) == null) {
                                  return _langState.isEnglish
                                      ? 'Please enter a number'
                                      : 'Bir sayı yazın';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                price = int.parse(newValue);
                              },
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                            ),
                            Divider(
                              height: 30,
                            ),
                            Center(
                              child: DateTimePicker(
                                locale: _langState.isEnglish
                                    ? const Locale('en', 'EN')
                                    : const Locale('tr', 'TR'),
                                textAlign: TextAlign.center,
                                initialValue: DateTime.now().toString(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                dateLabelText:
                                    _langState.isEnglish ? 'Date' : 'Tarih',
                                onChanged: (val) => time = val,
                                validator: (val) {
                                  print(val);
                                  return null;
                                },
                                onSaved: (val) {
                                  val = Jiffy(val).format('dd/MM/yyyy');
                                  time = val;
                                },
                              ),
                            ),
                            Divider(),
                            DropdownButton<String>(
                              value: category,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  category = newValue;
                                });
                              },
                              items: categoryList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
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
