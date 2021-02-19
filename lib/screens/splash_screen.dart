import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gelir_gider/screens/expenses_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/custom_theme_modal.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 1;

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ExpensesListScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<CustomThemeModal>(context, listen: false);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: _theme.getThemeData.brightness == Brightness.dark
                  ? [Color(0xff191919), Color(0xff191919)]
                  : [Colors.purple, Colors.pink]),
        ),
        child: InkWell(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.attach_money,
                          size: 75,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
