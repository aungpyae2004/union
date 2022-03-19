import 'package:flutter/material.dart';

class UnionTheme {
  static TextTheme darkTextTheme = const TextTheme(
    headline2: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      fontFamily: 'OpenSans',
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      fontFamily: 'OpenSans',
      color: Colors.white,
    ),
    headline3: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'OpenSans',
      color: Colors.white,
    ),
  );

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      textTheme: darkTextTheme,
    );
  }
}
