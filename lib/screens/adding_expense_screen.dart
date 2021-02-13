import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:smart_select/smart_select.dart';

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
  String category = 'Payment';
  String time = '';
  bool isExpense = true;

  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'Payment', title: 'Payment'),
    S2Choice<String>(value: 'Food', title: 'Food'),
    S2Choice<String>(value: 'Clothes', title: 'Clothes'),
    S2Choice<String>(value: 'Shop', title: 'Shop'),
    S2Choice<String>(value: 'Travel', title: 'Travel'),
    S2Choice<String>(value: 'Education', title: 'Education'),
    S2Choice<String>(value: 'Entertainment', title: 'Entertainment'),
    S2Choice<String>(value: 'Others', title: 'Others'),
  ];
  List<S2Choice<String>> options2 = [
    S2Choice<String>(value: 'Ödeme', title: 'Ödeme'),
    S2Choice<String>(value: 'Gıda', title: 'Gıda'),
    S2Choice<String>(value: 'Giyim', title: 'Giyim'),
    S2Choice<String>(value: 'Alışveriş', title: 'Alışveriş'),
    S2Choice<String>(value: 'Seyahat', title: 'Seyahat'),
    S2Choice<String>(value: 'Eğitim', title: 'Eğitim'),
    S2Choice<String>(value: 'Eğlence', title: 'Eğlence'),
    S2Choice<String>(value: 'Diğer', title: 'Diğer'),
  ];

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
    final _langState = Provider.of<LanguageHandler>(context, listen: false);
    final snackBar = SnackBar(
      content: Container(
        child: Text(
          _langState.isEnglish ? 'Transaction added' : 'İşlem eklendi',
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.overline.color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).primaryColor,
    );
    category = _langState.isEnglish ? 'Payment' : 'Ödeme';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              _langState.isEnglish ? 'Add Income/Expense' : 'Gelir/Gider Ekle'),
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
                            SmartSelect<String>.single(
                                title: _langState.isEnglish
                                    ? 'Categories'
                                    : 'Kategoriler',
                                placeholder: _langState.isEnglish
                                    ? 'Select One'
                                    : 'Seçiniz',
                                value: category,
                                modalHeaderStyle: S2ModalHeaderStyle(
                                    iconTheme: IconThemeData(
                                        color: Theme.of(context).buttonColor),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    textStyle: TextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6
                                            .color)),
                                choiceStyle: S2ChoiceStyle(
                                    titleStyle: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color)),
                                choiceItems:
                                    _langState.isEnglish ? options : options2,
                                onChange: (state) => setState(() {
                                      category = state.value;
                                    })),
                            Divider(
                              height: 30,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: _langState.isEnglish
                                    ? 'Description'
                                    : 'Açıklama'

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
                                price = double.parse(newValue);
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
