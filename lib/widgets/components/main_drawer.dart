import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/widgets/dialogs/theme_dialog_widget.dart';
import 'package:gelir_gider/screens/language_selection_screen.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gelir_gider/helpers/notification_helper.dart';
import 'package:gelir_gider/screens/expenses_list_screen.dart';

// Sağ üst köşede bulunan ... ikonuna sahip butonumuzun tıklandığında açılması
// gereken kısmın tasarımı ve arkaplan işlemlerinin yazıldığı kısım

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer>{
  var notificationEnabled=false;
  var hour=21;
  var minute=0;

  @override
  void initState() {
    super.initState();
    _loadValues();
    checkNotifications();
  }
  void checkNotifications() async{
    if(notificationEnabled){
      print('enabled');
      notificationHelper.setListenerForLowerVersions(onNotificationInLowerVersions);
      notificationHelper.setOnNotificationClick(onNotificationClick);
      await notificationHelper.showDailyAtTime(hour,minute);
    }
    else{
      print('disabled');
      await notificationHelper.cancelAllNotification();
    }
  }
  void _loadValues() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
       notificationEnabled= (prefs.getBool('notification')) ?? false;
       hour= (prefs.getInt('hour')) ?? 21;
       minute= (prefs.getInt('minute')) ?? 0;
    });
    await checkNotifications();
  }
  void _saveValues() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('notification',notificationEnabled);
      prefs.setInt('hour',hour);
      prefs.setInt('minute',minute);
    });
    await checkNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    var isDark = _theme.getTheme() == _theme.dark;
    var provider = Provider.of<Expenses>(context, listen: false);
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    void showThemePicker() {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return ThemeDialogWidget();
        },
      );
    }
    return Drawer(
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: Colours.getGradientColors(isDark)),
            ),
            child: DrawerHeader(
              child: Icon(
                Icons.attach_money,
                size: textScaleFactor*30,
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
            onTap: () {
              Navigator.pop(context);
              showThemePicker();
            },
            title: Text(
              S.of(context).DrawerThemeText,
              style: TextStyle(fontSize: 16 * textScaleFactor),
            ),
            leading: Icon(
              Icons.color_lens,
              size: 30*textScaleFactor,
              color: Theme.of(context).buttonColor,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
            onTap: () {
              return Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => LanguageSelectionScreen(),
                ),
              );
            },
            title: Text(
              S.of(context).DrawerLanguageText,
              style: TextStyle(fontSize: 16 * textScaleFactor),
            ),
            leading: Icon(
              Icons.language,
              size: 30*textScaleFactor,
              color: Theme.of(context).buttonColor,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
            onTap: () async {
              return await showCurrencyPicker(
                context: context,
                showFlag: true,
                showCurrencyName: true,
                showCurrencyCode: true,
                onSelect: (Currency currency) async {
                  print('Select currency symbol: ${currency.symbol}');
                  await provider.setCurrency(currency.symbol);
                  await Navigator.of(context).pop();
                },
              );
            },
            title: Text(
              S.of(context).DrawerSelectCurrency,
              style: TextStyle(fontSize: 16 * textScaleFactor),
            ),
            leading: Icon(
              Icons.euro,
              size: 30*textScaleFactor,
              color: Theme.of(context).buttonColor,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
            onTap: () {
              Navigator.of(context).push(
                showPicker(
                  context: context,
                  value: TimeOfDay(hour:hour,minute:minute),
                  onChange: (value) {
                      hour=value.hour;
                      minute=value.minute;
                      notificationEnabled=true;
                      _saveValues();
                  },
                  cancelText: S.of(context).Cancel,
                  okText: S.of(context).OK,
                  is24HrFormat: true
                ),
              );
            },
            title: Text(
             S.of(context).Notifications,
              style: TextStyle(fontSize: 16 * textScaleFactor),
            ),
            leading: Icon(
              Icons.notifications_active_outlined,
              size: 30*textScaleFactor,
              color: Theme.of(context).buttonColor,
            ),
            trailing:Switch(
              onChanged: (value) {
                notificationEnabled = value;
                _saveValues();
              },
              value: notificationEnabled,
              activeColor:Colours.colorGradient2,
            ) ,
          ),
        ],
      ),
    );
  }
  void onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  void onNotificationClick(String payload) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ExpensesListScreen();
    }));
  }
}
