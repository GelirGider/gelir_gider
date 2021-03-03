import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class AccountChanger extends StatelessWidget {
  final controller;

  const AccountChanger(this.controller);
  @override
  Widget build(BuildContext context) {
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    return Consumer<Expenses>(
      child: null,
      builder: (context, provider, child) {
        return FloatingActionButton(
          backgroundColor: Colors.transparent,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                provider.isPersonal
                    ? 'assets/account_selector/man.png'
                    : 'assets/account_selector/suitcase (2).png',
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          onPressed: () {
            showGeneralDialog(
              barrierLabel: "Label",
              barrierDismissible: true,
              barrierColor: Colours.accChangerDialogBarrier,
              transitionDuration: Duration(milliseconds: 700),
              context: context,
              pageBuilder: (context, anim1, anim2) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 0,
                    ),
                    decoration: BoxDecoration(
                      color: _theme.getTheme() == _theme.dark
                          ? Colors.black
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                    ),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            FlatButton(
                              onPressed: () async {
                                await provider.setPersonal();
                                provider.setTabBarIndex(0);
                                controller.index = 0;
                                await Navigator.of(context).pop();
                              },
                              child: Text(
                                S.of(context).AppBarIndividual,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0 * textScaleFactor,
                                  letterSpacing: 0.7,
                                  color: Theme.of(context).buttonColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.12,
                            ),
                            Icon(
                              Icons.person,
                              color: Theme.of(context).buttonColor,
                              size: 25.0,
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton(
                              onPressed: () async {
                                await provider.setCorporate();
                                provider.setTabBarIndex(0);
                                controller.index = 0;
                                await Navigator.of(context).pop();
                              },
                              child: Text(
                                S.of(context).AppBarCorporate,
                                style: TextStyle(
                                  fontSize: 25.0 * textScaleFactor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.7,
                                  color: Theme.of(context).buttonColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.12,
                            ),
                            Icon(
                              Icons.work,
                              color: Theme.of(context).buttonColor,
                              size: 25.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                      .animate(anim1),
                  child: child,
                );
              },
            );
          },
        );
      },
    );
  }
}
