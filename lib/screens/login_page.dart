import 'package:catalog_app/services/auth.dart';
import 'package:catalog_app/services/google_auth.dart';
import 'package:catalog_app/utils/routes.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isLoadingGoogle = false;

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
               "Welcome",
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
                   SizedBox(height: 50.0),
                   TextFormField(
                     decoration: InputDecoration(
                       hintText: "Enter Email",
                       labelText: "Email",
                     ),
                     validator: (value){
                       if (value!.isEmpty){
                         return "Email cannot be empty";
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
                   SizedBox(height: 5),
                   Container(
                     alignment: Alignment.centerRight,
                     child: Container(
                       padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                       child: Text("Forgot Password?"),
                     ),
                   ),
                   SizedBox(height: 25.0),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       InkWell(

                         onTap: () => moveToHome(context),
                         child: AnimatedContainer(
                           duration: Duration(milliseconds: 200),
                           width: changeBtn ? 50:150,
                           height: 40,

                           alignment: Alignment.center,
                           child: changeBtn
                               ?Icon(Icons.done,color: Colors.white)
                               :Text(
                             "Sign In",
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 12,
                               fontFamily: "Poppins",
                               // fontWeight: FontWeight.bold,
                             ),

                           ),
                           decoration: BoxDecoration(
                               color: Colors.deepOrangeAccent,
                             borderRadius: BorderRadius.circular(changeBtn?50:15)
                           ),

                         ),
                       ),
                       SizedBox(width: 0),
                       // ElevatedButton(
                       //     child:
                       //     Text("Login"),
                       //     onPressed: (){},
                       //     style: ElevatedButton.styleFrom(
                       //       primary: Colors.deepOrangeAccent,
                       //       onPrimary: Colors.white,
                       //     )
                       // ),
                       // SizedBox(width: 15,),
                       // ElevatedButton(
                       //   child:
                       //   Text("Sign Up"),
                       //   onPressed: (){},
                       //   style: ElevatedButton.styleFrom(
                       //     primary: Colors.deepOrangeAccent,
                       //     onPrimary: Colors.white,
                       //   )
                       //   ),
                       Container(

                         padding: const EdgeInsets.all(0.0),

                         height: 40,
                         alignment: Alignment.center,
                         child: OutlinedButton.icon(

                           onPressed: (){
                             AuthMethods().signInWithGoogle(context);
                           },
                           icon: FaIcon(FontAwesomeIcons.google, color: Colors.deepOrangeAccent),
                           label: Text(
                             "Sign In Using Google",
                             style: TextStyle(
                               color: Colors.deepOrangeAccent,
                               fontSize: 10,



                               fontFamily: "Poppins",

                               // fontWeight: FontWeight.bold,
                             ),

                           ),
                           style: OutlinedButton.styleFrom(
                               elevation: 0,
                               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                           ),

                         ),
                         decoration: BoxDecoration(
                             border: Border.all(color: Colors.deepOrangeAccent, width: 3),


                             color: Colors.white54,
                             borderRadius: BorderRadius.circular(15)
                         ),


                       ),
                     ],

                   ),


                   SizedBox(height: 25.0),
                   Row(mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text("Don't have an account?",style: TextStyle(
                         fontSize: 15,
                       ),
                       ),
                       SizedBox(width: 5,),
                       Text("Register Now",style: TextStyle(
                         fontSize: 15,
                         decoration: TextDecoration.underline,

                       )
                       ),
                     ],
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
