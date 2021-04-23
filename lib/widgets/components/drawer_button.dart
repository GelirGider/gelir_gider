import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {

  // Programın sağ üst köşesinde bulunan ... ikonuna sahip butonumuz

  final scaffoldKey;
  const DrawerButton({Key key, this.scaffoldKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return IconButton(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
      icon: Container(
        child: Icon(
          Icons.more_horiz,
          size: size.width*0.075,
          color: Theme.of(context).buttonColor,
        ),
      ),
      onPressed: () => scaffoldKey.currentState.openEndDrawer(),
    );
  }
}
