import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/language_provider.dart';
import 'package:provider/provider.dart';

class SwitchButton extends StatefulWidget {
  bool isSwitched;

  SwitchButton({Key key, this.isSwitched}) : super(key: key);
  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    final _langState = Provider.of<LanguageHandler>(context, listen: false);
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              _langState.isEnglish ? 'income' : 'gelir',
            ),
          ),
          Container(
            child: Switch(
              onChanged: (bool value) {
                setState(() {
                  widget.isSwitched = value;
                });
              },
              value: widget.isSwitched,
              activeTrackColor: Colors.yellow,
              activeColor: Colors.orangeAccent,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              _langState.isEnglish ? 'expense' : 'gider',
            ),
          ),
        ],
      ),
    );
  }
}
