import 'package:flutter/material.dart';

class BottomSpace extends StatelessWidget {

  // Ekleme ekranına giden butonumuzun harcama kısmını
  // örtmemesi için yaptığımız component

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(),
    );
  }
}
