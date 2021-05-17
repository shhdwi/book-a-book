import 'package:catalog_app/screens/home_page.dart';
import 'package:catalog_app/screens/login_page.dart';
import 'package:catalog_app/utils/routes.dart';
import 'package:catalog_app/widgets/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),


      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.homeRoute:(context)=>Homepage(),
        MyRoutes.loginRoute:(context)=>LoginPage(),


      },
      debugShowCheckedModeBanner: false,
        );
  }
}
