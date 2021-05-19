import 'package:catalog_app/helper_functions/Authentication.dart';
import 'package:catalog_app/screens/home_page.dart';
import 'package:catalog_app/screens/login_page.dart';
import 'package:catalog_app/screens/signup.dart';
import 'package:catalog_app/services/auth.dart';
import 'package:catalog_app/utils/routes.dart';
import 'package:catalog_app/widgets/nav.dart';
import 'package:catalog_app/widgets/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: AuthMethods().getCurrentUser(),
        builder: (context , AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            return MyHomePage();
          }else{
            return Authenticate();
          }
        },
      ),
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),

      routes: {
        MyRoutes.homeRoute:(context)=>Homepage(),
        MyRoutes.loginRoute:(context)=>Authenticate(),


      },
      debugShowCheckedModeBanner: false,
        );
  }
}
