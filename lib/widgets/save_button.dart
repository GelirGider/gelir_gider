import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';

class SaveButton extends StatelessWidget {
  final onPressed;

  const SaveButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: Colors.pink,
        child: Text(
          S.of(context).AddingScreenSave,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
            fontSize: 22.0,
            color: Colors.white,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
