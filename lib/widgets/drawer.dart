import 'package:catalog_app/helper_functions/Authentication.dart';
import 'package:catalog_app/helper_functions/sharedpref_helper.dart';
import 'package:catalog_app/screens/Developers.dart';
import 'package:catalog_app/screens/nav_bottom.dart';

import 'package:catalog_app/screens/profile.dart';
import 'package:catalog_app/services/auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



// ignore: must_be_immutable
class MyDrawer extends StatelessWidget{

  AuthMethods authMethods =new AuthMethods();

  @override
   Widget build(BuildContext context) {

    Future displayName =SharedPreferenceHelper().getDisplayName();
    // String email = SharedPreferenceHelper().getEmailValues();
    // String? imageUrl= user!.photoURL;
    print(displayName);

    // print(email);
    // print(imageUrl);




    return Drawer(
      child: Container(
        color: Colors.orange[50],
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,



                child: FutureBuilder(
                  future: SharedPreferenceHelper().getUserinfo(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData){
                      Map userinfo=snapshot.data;
                      return UserAccountsDrawerHeader(
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Colors.orange[200],),
                        accountEmail: Text(userinfo["email"]),
                        accountName: Text(userinfo["name"]),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Colors.white,
                           backgroundImage: NetworkImage(userinfo["imgUrl"]),
                        //),


                        ));


                    }
                    return Container(
                        child: Center(child: CircularProgressIndicator()));


                  },
                )
            ),
            GestureDetector(
              onTap:(){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));},
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.home,
                  color: Colors.black45,
                ),
                title: Text("Home"),



              ),
            ),
            GestureDetector(
              onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));},
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.black45,
                ),
                title: Text("Profile"),



              ),
            ),
            GestureDetector(
              onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>DevSus()));},
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.heart,
                  color: Colors.redAccent,
                ),
                title: Text("Developers",style: TextStyle(color: Colors.redAccent),),



              ),
            ),
            GestureDetector(
              onTap: (){
                authMethods.SignOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Authenticate()));
              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.power,
                  color: Colors.black45,
                ),
                title: Text("Sign Out"),



              ),
            )
          ],

        ),
      ),

    );
  }
  
}