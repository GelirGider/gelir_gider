import 'dart:ui';

class Colours {
  Colours._();

  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const black = Color.fromRGBO(0, 0, 0, 1);
  static const red = Color.fromRGBO(255, 35, 0, 1);
  static const pink = Color.fromRGBO(230, 0, 100, 1);
  static const green = Color.fromRGBO(0, 235, 90, 0.8);
  static const grey = Color.fromRGBO(255, 255, 255, 0.5);
  static const categoryItemDarkBg = Color.fromRGBO(30, 30, 30, 1);
  static const colorGradient1 = Color.fromRGBO(227, 9, 23, 1);
  static const colorGradient2 = Color.fromRGBO(94, 23, 235, 1);
  static const colorGradientDark = Color.fromRGBO(33, 33, 33, 1);
  static const activeBgColor = Color.fromRGBO(255, 78, 132, 1);
  static const inactiveBgColor = Color.fromRGBO(188, 209, 225, 1);
  static const inactiveFgColor = Color.fromRGBO(0, 0, 0, 1);
  static const languageContainerBg = Color.fromRGBO(112, 128, 144, 1);
  static const languageCardBg = Color.fromRGBO(255, 255, 255, 0.6);
  static const accChangerDialogBarrier = Color.fromRGBO(0, 0, 0, 0.5);

  static List<Color> getGradientColors(bool isDark) {
    if (isDark) {
      return [colorGradientDark, colorGradientDark];
    } else {
      return [colorGradient1, colorGradient2];
    }
  }

  static Color getGradientNew2(bool isDark) {
    if (isDark) {
      return colorGradientDark;
    } else {
      return white;
    }
  }

  static Color getBlackOrWhite(bool isDark) {
    if (isDark) {
      return white;
    } else {
      return black;
    }
  }

  static Color getCategoryItemBg(bool isDark) {
    if (isDark) {
      return categoryItemDarkBg;
    } else {
      return white;
    }
  }

  static Color getCategoryItemBorder(bool isDark) {
    if (isDark) {
      return grey;
    } else {
      return black;
    }
  }

  static Color getGradientNew(bool isDark) {
    if (isDark) {
      return pink;
    } else {
      return pink;
    }
  }
}
