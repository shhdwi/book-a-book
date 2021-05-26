import 'package:catalog_app/widgets/themes.dart';
import 'package:flutter/material.dart';

class DevSus extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(
            color: ColorMe.cadetgrey),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 35,vertical: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Made with ❤ by Junior Developers of DevSoc:",style: TextStyle(color: Colors.red[300],fontFamily: "Poppins",fontSize: 28,fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text("Shrish Dwivedi",style: TextStyle(color: Colors.deepOrangeAccent,fontFamily: "Poppins",fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("Gaurang Aswal",style: TextStyle(color: Colors.deepOrangeAccent,fontFamily: "Poppins",fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("Lalita Pulavarti",style: TextStyle(color: Colors.deepOrangeAccent,fontFamily: "Poppins",fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("Shubhi Bhandari",style: TextStyle(color: Colors.deepOrangeAccent,fontFamily: "Poppins",fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text("Special Thanks to : Arvind bhaiya, Rishabh Bhaiya, Ritvij Bhaiya, Umang Bhaiya for helping us during this project",style: TextStyle(color: Colors.deepOrangeAccent,fontFamily: "Poppins",fontSize: 16,))


            ],
          ),
        ),
      );
  }
}
