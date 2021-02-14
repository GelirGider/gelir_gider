import 'package:flutter/material.dart';

class DismissibleBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
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
