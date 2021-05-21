import 'package:catalog_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
        future: AuthMethods().getUserCred(),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        Map userinfo = snapshot.data;

        return Container(
          child: Padding(
            padding: EdgeInsets.only(top: 90.0),
            child: Column(
              children: [
                Text(
                  'Your Profile',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 30.0),
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        userinfo['imgUrl']),
                    radius: 65.0,
                  ),
                ),
                SizedBox(height: 18.0),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 16.0, 30.0, 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.deepOrangeAccent,
                            size: 30.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text('Name',style: TextStyle(color: Colors.deepOrangeAccent),),
                              Text(userinfo['name']),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 16.0, 30.0, 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Icon(
                            Icons.android,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text('username'),
                              Text(userinfo['username']),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Icon(
                            Icons.mail_outline,
                            color: Colors.grey,
                            size: 30.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text('Email'),
                              Text(userinfo['email']),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
       return Container(
          child: Center(child: CircularProgressIndicator()));
    },),
    );
  }
}
