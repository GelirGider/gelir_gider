import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/switch_button.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';

class AddingExpense extends StatefulWidget {
  @override
  _AddingExpenseState createState() => _AddingExpenseState();
}

class _AddingExpenseState extends State<AddingExpense> {
  final _form = GlobalKey<FormState>();

  var _isLoading = false;

  List<String> gelirMiGiderMi = ['gelir', 'gider'];
  List<String> expenseOrIncome = ['expense', 'income'];

  String description = 'asdas';
  int price = 0;
  String category = "Eğlence";
  String time = '';
  bool isExpense = true;

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
        description: description,
        price: price,
        time: time,
        category: category,
        isExpense: isExpense,
      ),
    );
    await Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _langState = Provider.of<LanguageHandler>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _langState.isEnglish ? 'Add Income/Expense' : 'Gelir/Gider ekle'),
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
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Form(
                    key: _form,
                    child: Column(children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              _langState.isEnglish ? 'description' : 'açıklama',
                          fillColor: Colors.orangeAccent,
                          focusColor: Colors.orangeAccent,
                          hoverColor: Colors.orangeAccent,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pinkAccent,
                              width: 2,
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value.isEmpty) {
                            return _langState.isEnglish
                                ? 'Please provide a name.'
                                : 'Bir açıklama ekleyin';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          description = newValue;
                        },
                      ),
                      Divider(
                        height: 50,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: _langState.isEnglish ? 'price' : 'fiyatı',
                          fillColor: Colors.orangeAccent,
                          focusColor: Colors.orangeAccent,
                          hoverColor: Colors.orangeAccent,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pinkAccent,
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
                          description = newValue;
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                      Center(
                        child: SwitchButton(
                          isSwitched: isExpense,
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(30),
                          child: DateTimePicker(
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            dateLabelText: _langState.isEnglish ? 'Date' : 'Tarih',
                            onChanged: (val) => time = val,
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) {
                              var jiffy = Jiffy(val);
                              val = jiffy.format("dd/MM/yyy");
                              time = val;
                            }
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ]),
            ),
    );
  }
}