import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_icons/country_icons.dart';

class FlagButton extends StatelessWidget {
  final bool isEnglish;
  final Function onPressed;

  const FlagButton({Key key, this.isEnglish, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 150,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            isEnglish
                ? Image.asset('icons/flags/png/gb.png',
                    package: 'country_icons')
                : Image.asset('icons/flags/png/tr.png',
                    package: 'country_icons'),
            isEnglish ? SizedBox(height: 10) : SizedBox(height: 30),
            Text(isEnglish ? 'English' : 'Türkçe',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
