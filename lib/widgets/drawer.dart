import 'package:catalog_app/helper_functions/sharedpref_helper.dart';
import 'package:catalog_app/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget{
  String? get userProfilePicKey => null;

  @override
   Widget build(BuildContext context) {


    final imageUrl = SharedPreferenceHelper().getUserProfileUrl();
    return Drawer(
      child: Container(
        color: ColorMe.Lemon,
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,



                child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: ColorMe.darklemon,),
                  accountEmail: Text("dwi.shrish@gmail.com"),
                  accountName: Text("Shrish Dwivedi"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage("https://i.stack.imgur.com/frlIf.png"),
                  ),


            )
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.black45,
              ),
              title: Text("Home"),



            )
          ],

        ),
      ),

    );
    throw UnimplementedError();
  }
  
}