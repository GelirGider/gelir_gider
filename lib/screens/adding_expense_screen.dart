import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/ad_state.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/components/main_drawer.dart';
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
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AddingExpense extends StatefulWidget {
  // Ekleme ekranının tasarımı ve tüm arkaplanının yapıldığı kısım

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
    InterstitialAd myInterstitial;
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    final adState = Provider.of<AdState>(context);
    await adState.init.then(
      (value) => myInterstitial = InterstitialAd(
        adUnitId: Provider.of<AdState>(context).adUnitId,
        request: AdRequest(),
        listener: adState.listener,
      ),
    )
      ..load();

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
    await myInterstitial.show();
    Navigator.of(context).pop();
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
    final size = MediaQuery.of(context).size;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    category = Provider.of<Expenses>(context, listen: false).CurrentCategory;

    return SafeArea(
      child: Scaffold(
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
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: Theme.of(context).buttonColor,
                    ),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,

                    ///it opens a drawer
                  ),
                ),
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
                        minWidth: textScaleFactor * 120.0,
                        minHeight: textScaleFactor * 60.0,
                        fontSize: 17.0 * textScaleFactor,
                        initialLabelIndex: 0,
                        cornerRadius: 60.0 * textScaleFactor,
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
                              height: 30 * textScaleFactor,
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
                              height: size.height * 0.030,
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
                              height: size.height * 0.030,
                            ),
                            SaveButton(
                              onPressed: () => _saveForm(),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
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
