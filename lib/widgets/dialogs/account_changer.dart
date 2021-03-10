import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:gelir_gider/providers/theme_provider.dart';
import 'package:gelir_gider/widgets/components/divider.dart';
import 'package:provider/provider.dart';

class AccountChanger extends StatelessWidget {

  // Sol üst köşede bulunan hesap değiştirme için tasarladığımız butona
  // tıkladığımız vakit alt taraftan açılan dialog un tasarım ve arkaplanının
  // oluşturulduğu kısım

  final controller;

  const AccountChanger(this.controller);
  @override
  Widget build(BuildContext context) {
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final _theme = Provider.of<ThemeProvider>(context, listen: false);
    return Consumer<Expenses>(
      child: null,
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            backgroundColor:  Theme.of(context).buttonColor,
            child: CircleAvatar(
              minRadius: 1.0,
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
                barrierLabel: 'Label',
                barrierDismissible: true,
                barrierColor: Colours.accChangerDialogBarrier,
                transitionDuration: Duration(milliseconds: 700),
                context: context,
                pageBuilder: (context, anim1, anim2) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10.0
                      ),
                      decoration: BoxDecoration(
                        color: _theme.getTheme() == _theme.dark
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                      ),
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                    fontSize: 20.0 * textScaleFactor,
                                    letterSpacing: 0.8,
                                    color: Theme.of(context).buttonColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.10,
                              ),
                              Icon(
                                Icons.person,
                                color: Theme.of(context).buttonColor,
                                size: 20.0*textScaleFactor,
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
                                    fontSize: 20.0 * textScaleFactor,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                    color: Theme.of(context).buttonColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.10,
                              ),
                              Icon(
                                Icons.work,
                                color: Theme.of(context).buttonColor,
                                size: 20.0*textScaleFactor,
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
          ),
        );
      },
    );
  }
}
