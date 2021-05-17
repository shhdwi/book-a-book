
import 'package:flutter/material.dart';

class MyTheme{
  static ThemeData lightTheme(BuildContext context) => ThemeData(
  fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(
  color: Colors.white,
  elevation: 0.0,
  iconTheme: IconThemeData(color: Colors.black45 ),
  textTheme: Theme.of(context).textTheme,


  ));
  static ThemeData darkTheme(BuildContext context) => ThemeData(
    brightness: Brightness.dark,
  );
}