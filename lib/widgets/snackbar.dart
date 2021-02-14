import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Snackbar extends SnackBar {
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Container(
        child: Text(
          'İşlem silindi',
          style: TextStyle(
            color: Theme.of(context).textTheme.overline.color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.red,
    );
  }
}
