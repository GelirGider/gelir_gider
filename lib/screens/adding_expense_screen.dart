import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/ad_state.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/components/main_drawer.dart';
import 'package:gelir_gider/widgets/components/drawer_button.dart';
import 'package:gelir_gider/widgets/buttons/save_button.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  // Ekleme ekranının tasarımı ve tüm arkaplanının yapıldığı kısım

  final scaffoldKey;

  const AddingExpense({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _AddingExpenseState createState() => _AddingExpenseState();
}

class _AddingExpenseState extends State<AddingExpense>
    with TickerProviderStateMixin {
  InterstitialAd myInterstitial;
  static final _form = GlobalKey<FormState>();
  var _isLoading = false;
  String description = '';
  double price = 0.0;
  String time = '';
  bool isExpense = false;
  var category;
  var id = -1;

  void moveToSecondPage() async {
    id = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => CategoryScreen(),
      ),
    ) ?? -1;
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
        category: id,
        isExpense: isExpense ? 'expense' : 'income',
        time: time,
        price: isExpense ? (price * (-1)) : price,
        description: description,
      ),
    );
    Navigator.of(context).pop();
    await myInterstitial.show();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      category = Provider.of<Expenses>(context, listen: false).currentCategory;
    });
    final adState = Provider.of<AdState>(context);
    adState.init.then((value) {
      setState(() {
        myInterstitial = InterstitialAd(
          adUnitId: adState.adUnitId,
          request: AdRequest(),
          listener: adState.addListener,
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    var isDark = _theme.getTheme() == _theme.dark;
    final size = MediaQuery.of(context).size;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    category = Provider.of<Expenses>(context, listen: false).currentCategory;

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: MainDrawer(),
        appBar: PreferredSize(
            preferredSize: size / 6.5,
            child: GradientAppBar(
              iconTheme: IconThemeData(
                  color: Colours.getGradientNew(isDark) //change your color here
                  ),
              shape: Border(
                  bottom: BorderSide(
                      width: 3.0 * textScaleFactor,
                      color: Colours.getGradientNew(isDark))),
              gradient: LinearGradient(colors: Colours.getGradientNew2(isDark)),
              centerTitle: true,
              actions: [
                Builder(
                    builder: (context) =>
                        DrawerButton(scaffoldKey: scaffoldKey)),
              ],
              title: Icon(
                Icons.attach_money,
                color: Theme.of(context).buttonColor,
              ),
            )),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.025),
                      child: ToggleSwitch(
                        minWidth: textScaleFactor * 70.0,
                        minHeight: textScaleFactor * 40.0,
                        fontSize: 12.0 * textScaleFactor,
                        initialLabelIndex: 0,
                        cornerRadius: 60.0 * textScaleFactor,
                        activeBgColor:
                            isExpense ? Colours.inactiveBgColor : Colours.green,
                        activeFgColor:
                            isExpense ? Colours.black : Colours.white,
                        inactiveBgColor:
                            isExpense ? Colours.red : Colours.inactiveBgColor,
                        inactiveFgColor:
                            isExpense ? Colours.white : Colours.black,
                        labels: [
                          S.of(context).AddingScreenIncome,
                          S.of(context).AddingScreenExpense,
                        ],
                        onToggle: (index) {
                          setState(() {
                            if (index == 0) {
                              isExpense = false;
                            }
                            if (index == 1) {
                              isExpense = true;
                            }
                          });
                          print('switched to: $index');
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.016,
                          vertical: size.height * 0),
                      child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                moveToSecondPage();
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.016,
                                    vertical: size.height * 0.025),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                      width: textScaleFactor * 1,
                                      color: Colours.getBlackOrWhite(isDark)),
                                ),
                                width: 250.0 * textScaleFactor,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.010,
                                    vertical: size.height * 0.010),
                                child: id == -1
                                    ? ListTile(
                                        title: Text(
                                          S.of(context).SelectCategory,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 19.0 * textScaleFactor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    : ListTile(
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
                            SizedBox(
                              height: size.height * 0.030,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: S.of(context).AddingScreenPrice,
                              ),
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return S.of(context).AddPrice;
                                }
                                if (double.tryParse(value) == null) {
                                  return S.of(context).EnterNumber;
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                price = double.parse(newValue);
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.030,
                            ),
                            Center(
                              child: DateTimePicker(
                                textAlign: TextAlign.center,
                                initialValue: DateTime.now().toString(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
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
                            SizedBox(
                              height: size.height * 0.030,
                            ),
                            SaveButton(
                              onPressed: () {
                                if (id == -1) {
                                  scaffoldKey.currentState
                                      .showSnackBar(new SnackBar(
                                    content:
                                        new Text(S.of(context).CategoryWarning),
                                  ));
                                } else {
                                  return _saveForm();
                                }
                              },
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
