import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Center(
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