import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
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
        gradient: LinearGradient(
          colors: [Colors.red, Colors.purple],
        ),
      ),
    );
  }
}
