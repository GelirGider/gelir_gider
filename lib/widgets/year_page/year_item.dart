import 'package:flutter/material.dart';
import 'package:gelir_gider/themes/colours.dart';
import 'package:provider/provider.dart';
import 'package:gelir_gider/providers/providers.dart';

class YearListItem extends StatelessWidget {

  // Yıl kısmına ilk bastığımızda oluşan kısımda gözüken butonların tasarımı ve
  // tıklandığında yapılacak işlemlerin bulunduğu kısım

  final int year;
  const YearListItem({Key key, this.year}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Expenses>(
      child: null,
      builder: (context, provider, child) {
        return TextButton(
          onPressed: () {
            provider.setSelectedYear(year);
            provider.setSelectedPage(1);
          },
          style: TextButton.styleFrom(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
            padding: EdgeInsets.symmetric(vertical: 30,horizontal: 15),
            backgroundColor: Colours.pink,
          ),
          child: Text(
            year.toString(),
            style: TextStyle(
              color: Colours.white,
            ),
          ),
        );
      },
    );
  }
}
