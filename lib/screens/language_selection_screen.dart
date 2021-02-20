import 'package:flutter/material.dart';
import 'package:gelir_gider/generated/l10n.dart';
import 'package:gelir_gider/widgets/main_drawer.dart';

import 'expenses_list_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

List icons = [

  ClipRRect(
    borderRadius: BorderRadius.circular(60),
    child: Image.asset(
      'assets/flags/turkey.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(60),
    child: Image.asset(
      'assets/flags/usa.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(60),
    child: Image.asset(
      'assets/flags/germany.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(60),
    child: Image.asset(
      'assets/flags/arabia.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(60),
    child: Image.asset(
      'assets/flags/spain.png',
      fit: BoxFit.cover,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(60),
    child: Image.asset(
      'assets/flags/china.png',
      fit: BoxFit.cover,
    ),
  ),

  /* Image.asset('assets/flags/turkey.png',),
  Image.asset('assets/flags/usa.png'),
  Image.asset('assets/flags/germany.png'),
  Image.asset('assets/flags/arabia.png'),
  Image.asset('assets/flags/spain.png'),
  Image.asset('assets/flags/china.png'),*/
];

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final border = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    );
    final padding = const EdgeInsets.all(30.0);
    return Scaffold(
      backgroundColor: Colors.red,
      drawer: MainDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white60,
          margin: EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 50.0),

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  S.of(context).DrawerLanguageText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),


                Expanded(

                  child: GridView.count(
                    padding: padding,
                    crossAxisCount: 2,
                    children: List.generate(
                      icons.length,
                      (index) {
                        return FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          onPressed: () {
                            if (index == 0) {
                              S.load(Locale('tr'));
                            }
                            if (index == 1) {
                              S.load(Locale('en'));
                            }
                            if (index == 2) {
                              S.load(Locale('de'));
                            }
                            if (index == 3) {
                              S.load(Locale('ar'));
                            }
                            if (index == 4) {
                              S.load(Locale('es'));
                            }
                            if (index == 5) {
                              S.load(Locale('zh'));
                            }
                            return Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => ExpensesListScreen(),
                              ),
                            );
                          },
                          child: icons[index],
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  width: 270.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    color:Colors.greenAccent[400],
                    child:Text("DEVAM ET",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {}, ///???
                  ),
                ),
                SizedBox(height: 30.0,),



              ],



            ),


          ),


        ),


      ),

    );
  }
}
