import 'package:flutter/material.dart';
import 'package:gelir_gider/providers/custom_theme_modal.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/widgets/theme_dialog_widget.dart';
import 'package:gelir_gider/screens/language_selection_screen.dart';
import 'package:gelir_gider/generated/l10n.dart';


class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<CustomThemeModal>(context, listen: false);
    void showThemePicker() {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return ThemeDialogWidget();
        },
      );
    }

    return Drawer(
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: _theme.getThemeData.brightness == Brightness.dark
                      ? [Color(0xff191919), Color(0xff191919)]
                      : [Colors.purple, Colors.pink]),
            ),
            child: DrawerHeader(
              child: Icon(Icons.attach_money,size: 50,),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18),
            onTap: () {
              Navigator.pop(context);
              showThemePicker();
            },
            title: Text(S.of(context).DrawerThemeText,style: TextStyle(fontSize: 18),),
            leading: Icon(
              Icons.color_lens,
              size: 40,
              color: Theme.of(context).buttonColor,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18),
            onTap: () {
              return Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => LanguageSelectionScreen(),
                ),
              );
            },
            title: Text(S.of(context).DrawerLanguageText,style: TextStyle(fontSize: 18),),
            leading: Icon(
              Icons.language,
              size: 40,
              color: Theme.of(context).buttonColor,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
