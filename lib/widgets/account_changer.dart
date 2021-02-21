import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';

class AccountChanger extends StatelessWidget {
  final onPressed1;
  final onPressed2;

  const AccountChanger({Key key, this.onPressed1, this.onPressed2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset(
          'assets/account_selector/briefcase.png',
          height: 40,
          width: 40,
          colorBlendMode: BlendMode.darken,
          fit: BoxFit.scaleDown,
        ),
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: '1',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 70,
                ),
                FlatButton(
                  onPressed: onPressed1,
                  child: Text(S.of(context).AppBarIndividual),
                ),
                Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: '2',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  onPressed: onPressed2,
                  child: Text(S.of(context).AppBarCorporate),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.work,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
