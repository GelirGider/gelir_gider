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
        color: Colors.green,
        height: 100,
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(isEnglish ? 'English' : 'Türkçe'),
            isEnglish
                ? Image.asset('icons/flags/png/gb.png',
                    package: 'country_icons')
                : Image.asset('icons/flags/png/tr.png',
                    package: 'country_icons'),
          ],
        ),
      ),
    );
  }
}
