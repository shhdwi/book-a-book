import 'package:catalog_app/utils/routes.dart';
import "package:flutter/material.dart";

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name ="";
  bool changeBtn = false;

  final _formKey =GlobalKey<FormState>();
  moveToHome(BuildContext context)async{
    if (_formKey.currentState!.validate()){
      setState(() {
        changeBtn= true;

      });

    await Future.delayed(Duration(milliseconds: 210));


    await Navigator.pushNamed(context, MyRoutes.homeRoute);
    setState(() {
      changeBtn=false;
    });}
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Colors.white,
     child: SingleChildScrollView(
       child: Form(
         key: _formKey,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             SizedBox(height: 50.0),
             Text(
               "Welcome $name",
               style: TextStyle(
                 fontSize: 35,
                 fontFamily: "Poppins",
                 fontWeight: FontWeight.bold,

               ),

             ),

             Padding(
               padding: const EdgeInsets.symmetric(vertical: 25.0,horizontal: 32.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   SizedBox(height: 100.0),
                   TextFormField(
                     decoration: InputDecoration(
                       hintText: "Enter Username",
                       labelText: "Username",
                     ),
                     validator: (value){
                       if (value!.isEmpty){
                         return "Username cannot be empty";
                       }
                       return null;

                     },

                     onChanged: (value){
                       name=value;
                       setState(() {

                       });
                     },
                   ),
                   TextFormField(
                     obscureText: true,
                     decoration: InputDecoration(

                       hintText: "Enter Password",
                       labelText: "Password",

                     ),
                     validator: (value){
                       if (value==null){
                         return "Password cannot be empty";
                       }
                       else if (value.length<6){
                         return"Password length cannot be less than 6 characters";
                       }
                       return null;
                     },
                   ),
                   SizedBox(height: 25.0),
                   InkWell(
                     onTap: () => moveToHome(context),
                     child: AnimatedContainer(
                       duration: Duration(milliseconds: 200),
                       width: changeBtn ? 50:150,
                       height: 50,

                       alignment: Alignment.center,
                       child: changeBtn
                           ?Icon(Icons.done)
                           :Text(
                         "login",
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 20,
                           fontFamily: "Poppins",
                           fontWeight: FontWeight.bold,
                         ),

                       ),
                       decoration: BoxDecoration(
                           color: Colors.deepOrangeAccent,
                         borderRadius: BorderRadius.circular(changeBtn?50:15)
                       ),

                     ),
                   )

                 ],
               ),
             ),
             Image.asset("assets/images/login_image.png",fit: BoxFit.scaleDown,)


           ],
         ),
       ),
     ),
    );

  }
}
