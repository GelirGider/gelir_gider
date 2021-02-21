import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';

class AccountChanger extends StatelessWidget {
  final onPressed1;
  final onPressed2;
  final isPersonal;

  const AccountChanger(
      {Key key, this.onPressed1, this.onPressed2, this.isPersonal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 0,
      color: Colors.purple[100],
      shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.all( Radius.circular(20.0)),
      ),



      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(left: 8.0),
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
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: '1',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height:60,
                ),
                FlatButton(
                  onPressed: onPressed1,
                  child: Text(S.of(context).AppBarIndividual,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.7,
                    color: Colors.pink[900]
                  ),),
                ),

                Spacer(),
                Icon(
                  Icons.person,
                  color: Colors.pink[900],
                ),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: '2',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FlatButton(
                  onPressed: onPressed2,
                  child: Text(S.of(context).AppBarCorporate,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7,
                      color: Colors.pink[900],
                    ),),
                ),
                Spacer(),
                Icon(
                  Icons.work,
                  color: Colors.pink[900],
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
