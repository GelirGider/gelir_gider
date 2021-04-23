import 'package:flutter/material.dart';
import 'package:gelir_gider/themes/colours.dart';

class AddButton extends StatelessWidget {
  // Kullanıcıyı harcama ekleme sayfasına götüren buttonumuz

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: Icon(
        Icons.add,
        size: 40,
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: Colours.getGradientColors(false))),
    );
  }
}
