import 'package:catalog_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,


      body: Center(
        child: Text(
            "Home Page",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
          ),
        ),
      ),
      
    );
    throw UnimplementedError();
  }

}