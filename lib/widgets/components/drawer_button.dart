import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {

  // Programın sağ üst köşesinde bulunan ... ikonuna sahip butonumuz

  final scaffoldKey;
  const DrawerButton({Key key, this.scaffoldKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.more_horiz,
        size: 30.0,
        color: Theme.of(context).buttonColor,
      ),
      onPressed: () => scaffoldKey.currentState.openEndDrawer(),
    );
  }
}
