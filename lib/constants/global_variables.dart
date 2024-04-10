import 'package:flutter/material.dart';

class GlobalVariables {
  // COLORS
  static const secondaryColor = Color.fromRGBO(24, 119, 242, 1);
  static const backgroundColor = Colors.white;
  static const iconColor = Color.fromRGBO(137, 143, 156, 1);
}





class TextFontWeight {
  static FontWeight medium = FontWeight.w500;
  static FontWeight regular = FontWeight.w400;
  static FontWeight semibold = FontWeight.w600;

  ///
  static FontWeight extrabold = FontWeight.w800;
  static FontWeight bold = FontWeight.w700;
  static FontWeight black = FontWeight.w700;
}

class TextFontSize {
  static double px10 = 10;
  static double px11 = 11;
  static double px12 = 12;
  static double px13 = 13;
  static double px14 = 14;
  static double px15 = 15;
  static double px16 = 16;
  static double px17 = 17;
  static double px35 = 35;
  static double px32 = 32;
  static double px48 = 48;
  static double px24 = 24;
  static double px22 = 22;
  static double px20 = 20;

  static double px18 = 18;

///
}

class TextFontStyle {
  static FontStyle normal = FontStyle.normal;
  static FontStyle italic = FontStyle.italic;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class AppColorUtils {
  /// Newly Added
  static Color icons = HexColor('#45484D');
  static Color instruction = HexColor('#F5F5F5');
  static Color highlight = HexColor('#F5F8FF');
  static Color cards = HexColor('#E4EEFC');
  static Color card1 = HexColor('#D8E1F0');
  static Color buttons = HexColor('#0066FF');
  static Color backgroundgradientred = HexColor('#991210');
  static Color backgroundgradientblue = HexColor('#05037E');
  static Color white = HexColor('#FFFFFF');
  static Color lightgradient = HexColor('#E5F0FF');
  static Color grey2 = HexColor('#DCE0E5');

  static Color black = HexColor('#000000');
  static Color green = HexColor('#26AD26');
  static Color answerforum = HexColor('#FAFAFA');
  static Color certificate = HexColor('#555454');


  /// Newly Added

  /// Darkmode
  static Color DTgrey = HexColor('#E6E6E6');
  static Color svgcolor = HexColor('#040D15');
  static Color LTwhite = HexColor('#ECECEC');
  static Color DTshimmer = HexColor('#111E30');
  static Color DTshimmer2 = HexColor('#2C3B4D');
  static Color DTshimmericon = HexColor('##1B3047');
  static Color DTlightgrey = HexColor('#CCCCCC');
  static Color DTLTgrey60 = HexColor('#999999');
  static Color DTdovegrey = HexColor('#666666');
  static Color DTyellow = HexColor('#FFD60A');
  static Color DTlavendergrey = HexColor('#B8BFCC');
  static Color DTgoldenyellow = HexColor('#FEDC01');
  static Color red = HexColor('#C94646');

  static Color DTblue1 = HexColor('#0F1A26');
  static Color DTblueborder = HexColor('#182A3D');
  static Color DTgradient1 = HexColor('#071521');
  static Color DTgradient2 = HexColor('#0A1E30');
  static Color DTcardcolor = HexColor('#0B151F');
  static Color DTcardcolo2r = HexColor('#1A1D33');
  static Color DTforumcard = HexColor('#080E14');
  static Color DTforumcard1 = HexColor('#0C151F');
  static Color black1 = HexColor('#050D15');

  /// Darkmode

  ///Lightmode
  static Color LTlightblack = HexColor('#1A1A1A');
  static Color LTdarkcharcoal = HexColor('#333333');
  static Color LTdarkgrey = HexColor('#757575');
  static Color LTredpeppercorn = HexColor('#293FCC');

  ///?
  static Color LTgreydark = HexColor('#DBDBDB');

  //static Color DTLTgrey60 = HexColor1('#999999');
  static Color LTyellow = HexColor('#FFD60A');
  /// Light mode

  ///Unneccessary Color
  static Color DTgrey70 = HexColor('#B3B3B3');
  static Color LTgrey30 = HexColor('#4D4D4D');
  static Color DTblue = HexColor('#0A1E30');
  static Color basecolorpurple = HexColor('#3B2758');
  static Color basecolororange = HexColor('#3B758');
  static Color statsgreen = HexColor('#CFE5CF');
  static Color statsred = HexColor('#FAD7D7');
  static Color newborder = HexColor('#99C2FF');
  static Color LTline = HexColor('#F0F0F0');
  static Color secondarybuttons = HexColor('#050C13');

  static Color DTcolor1 = HexColor('#1A1D33');
  static Color DTicon = HexColor('#B8BFCC');
  static Color DTnotification = HexColor('#001324');
  static Color DTdark = HexColor('#08121F');
  static Color LTicon = HexColor('#EEF2F5');
  static Color splashColor1 = HexColor('#0054D3');
  static Color splashColor2 = HexColor('#275FB4');
  static Color gradient = HexColor('#3385FF');

  static Color LtBorder = HexColor('#D6E7FF');
  static Color red1 = HexColor('#C33939');
  static Color blue2 = HexColor('#0052CC');

  static Color appHeaderPurple = HexColor('#2C2973');

///Unneccessary Color
}

