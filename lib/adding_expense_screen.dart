import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:provider/provider.dart';

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
  DateTime time = DateTime(1999, 7, 13);
  String isExpense = 'Gelir';

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    Provider.of<Expenses>(context, listen: false).addExpense(
      Expense(
        description: description,
        price: price,
        time: time,
        isExpense: isExpense,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Books'),
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
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'description',
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
                              return 'Please provide a name.';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            description = newValue;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'price',
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
                              return 'Please provide a price.';
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
                      ],
                    ),
                  ),
                ),

//                Container(
//                  width: size.width / 2,
//                  padding: EdgeInsets.symmetric(vertical: 30),
//                  child: DropdownButton<String>(
//                    value: isExpense,
//                    icon: Icon(Icons.arrow_downward),
//                    iconSize: 24,
//                    elevation: 16,
//                    style: TextStyle(
//                      color: Colors.black,
//                    ),
//                    underline: Container(
//                      height: 3,
//                      color: Colors.orangeAccent,
//                    ),
//                    dropdownColor: Colors.orangeAccent,
//                    onChanged: (String newValue) {
//                      setState(() {
//                        isExpense = newValue;
//                      });
//                    },
//                    items: gelirMiGiderMi
//                        .map<DropdownMenuItem<String>>((String value) {
//                      return DropdownMenuItem<String>(
//                        value: value,
//                        child: Text(value),
//                      );
//                    }).toList(),
//                  ),
//                ),
              ],
            ),
    );
  }
}
