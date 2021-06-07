import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/themes/colours.dart';

class SaveButton extends StatelessWidget {
  // Ekleme ekranında bulunan kaydet butonu

  final onPressed;

  const SaveButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20 * textScaleFactor),
          ),
          padding: EdgeInsets.symmetric(vertical: 16 * textScaleFactor),
          backgroundColor: Colours.pink,
        ),
        child: Text(
          S.of(context).AddingScreenSave,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6 * textScaleFactor,
            fontSize: 22.0 * textScaleFactor,
            color: Colours.white,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
