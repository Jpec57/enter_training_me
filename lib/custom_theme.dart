import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static const color = Color(0xff000000);
  static const green = Color(0xffD3CEC4);
  static const middleGreen = Color(0xff857F72);
  static const darkGrey = Color(0xff27241D);

  static const MaterialColor greenSwatch = MaterialColor(
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffFAF9F7),//10%
      100: Color(0xffE8E6E1),//20%
      200: CustomTheme.green,//30%
      300: Color(0xffB8B2A7),//40%
      400: Color(0xffA39E93),//50%
      500: CustomTheme.middleGreen,//100%
      600: Color(0xff625D52),//60%
      700: Color(0xff504A40),//70%
      800: Color(0xff423D33),//80%
      900: CustomTheme.darkGrey,//90%
    },
  );

  static const MaterialColor redBlackSwatch = MaterialColor(
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffce5641 ),//10%
      100: Color(0xffb74c3a),//20%
      200: Color(0xffa04332),//30%
      300: Color(0xff89392b),//40%
      400: Color(0xff733024),//50%
      500: Color(0xff5c261d),//60%
      600: Color(0xff451c16),//70%
      700: Color(0xff2e130e),//80%
      800: Color(0xff170907),//90%
      900: Color(0xff000000),//100%
    },
  );

  static final theme = ThemeData(
    fontFamily: GoogleFonts.roboto().fontFamily,
    primarySwatch: CustomTheme.greenSwatch,
    appBarTheme: const AppBarTheme(backgroundColor: CustomTheme.darkGrey),
    backgroundColor: Colors.black,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      headline1: GoogleFonts.permanentMarker(color: Colors.white, fontSize: 60),
      headline2: GoogleFonts.permanentMarker(color: Colors.white, fontSize: 40),
      headline3: GoogleFonts.permanentMarker(color: Colors.white, fontSize: 30),
      headline4: GoogleFonts.permanentMarker(color: Colors.white, fontSize: 20),
    ).apply(
        bodyColor: Colors.white,
    )
  );
}