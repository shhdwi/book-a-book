import 'package:catalog_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Book a Book",
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 25,
        ),),
      ),
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
      drawer: MyDrawer(),

    );
    throw UnimplementedError();
  }

}