import 'package:flutter/material.dart';


class AddNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return SimpleDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      title: Text(
        "Add Notification",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, height: 2.5, letterSpacing: 1.0),
      ),
      children: <Widget>[
        Divider(
          color: Theme.of(context).textTheme.caption.color,
        ),
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Set Day",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15 * textScaleFactor),
              ),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).textTheme.caption.color,
        ),
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Set Time",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15 * textScaleFactor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
