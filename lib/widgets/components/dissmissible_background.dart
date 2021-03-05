import 'package:flutter/material.dart';
import 'package:gelir_gider/themes/colours.dart';

class DismissibleBackground extends StatelessWidget {

  //Silme işlemi için item'ı çektiğimizde gözükecek arkaplan

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Icon(
              Icons.delete,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
          ),
        ],
      ),
    );
  }
}
