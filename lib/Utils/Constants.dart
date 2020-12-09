import 'package:flutter/material.dart';
class Constants {
  static String appName = "Foody Bite";

  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Color(0xff5563ff);
  static Color darkAccent = Color(0xff5563ff);
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color ratingBG = Colors.yellow[600];
  static Color title=Colors.white;
  static Color appBarBackground=Color(0xfff79c4f);
  static BoxDecoration colorBoxDecoration=BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(2, 4),
            blurRadius: 5,
            spreadRadius: 2)
      ],
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xfffbb448), Color(0xfff7892b)]));

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
