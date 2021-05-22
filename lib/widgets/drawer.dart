import 'package:catalog_app/helper_functions/Authentication.dart';
import 'package:catalog_app/helper_functions/sharedpref_helper.dart';
import 'package:catalog_app/screens/login_page.dart';
import 'package:catalog_app/services/auth.dart';
import 'package:catalog_app/widgets/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyDrawer extends StatelessWidget{

  AuthMethods authMethods =new AuthMethods();

  @override
   Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    Future displayName =SharedPreferenceHelper().getDisplayName();
    // String email = SharedPreferenceHelper().getEmailValues();
    // String? imageUrl= user!.photoURL;
    print(displayName);

    // print(email);
    // print(imageUrl);




    return Drawer(
      child: Container(
        color: ColorMe.Lemon,
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
                          color: ColorMe.darklemon,),
                        accountEmail: Text(userinfo["email"]),
                        accountName: Text(userinfo["name"]),
                        currentAccountPicture: CircleAvatar(
                           backgroundImage: NetworkImage(userinfo["imgUrl"]),
                        //),


                        ));


                    }
                    return Container(
                        child: Center(child: CircularProgressIndicator()));


                  },
                )
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.black45,
              ),
              title: Text("Home"),



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
    throw UnimplementedError();
  }
  
}