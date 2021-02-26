import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/themes/colours.dart';

class AccountChanger extends StatelessWidget {
  final onPressed1;
  final onPressed2;
  final isPersonal;

  const AccountChanger(
      {Key key, this.onPressed1, this.onPressed2, this.isPersonal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            isPersonal
                ? 'assets/account_selector/man.png'
                : 'assets/account_selector/suitcase (2).png',
            height: 35,
            width: 35,
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
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                ),
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        FlatButton(
                          onPressed: onPressed1,
                          child: Text(
                            S.of(context).AppBarIndividual,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              letterSpacing: 0.7,
                              color: Colours.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Icon(
                          Icons.person,
                          color: Colors.white,
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
                          onPressed: onPressed2,
                          child: Text(
                            S.of(context).AppBarCorporate,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.7,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Icon(
                          Icons.work,
                          color: Colors.white,
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
              position:
                  Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
              child: child,
            );
          },
        );
      },
    );
  }
}
