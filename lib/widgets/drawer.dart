import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final imageUrl = "https://instagram.fbom3-1.fna.fbcdn.net/v/t51.2885-19/s320x320/162478445_292594488947473_4631024174712219261_n.jpg?tp=1&_nc_ht=instagram.fbom3-1.fna.fbcdn.net&_nc_ohc=1dnjye3mgrUAX8wjmjd&tn=qIYw6l8-oYQA_iN3&edm=ABfd0MgBAAAA&ccb=7-4&oh=24421544ad920ca0f86434d844b63734&oe=60C82FA7&_nc_sid=7bff83";
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  accountEmail: Text("dwi.shrish@gmail.com"),
                  accountName: Text("Shrish Dwivedi"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
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