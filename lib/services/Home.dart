import 'package:catalog_app/helper_functions/sharedpref_helper.dart';
import 'package:catalog_app/screens/chatscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:catalog_app/services/Database.dart';
import 'package:line_icons/line_icon.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearching = false;
   String? myName, myProfilePic, myUserName, myEmail;
   Stream? usersStream;
   Stream? chatroomStream;

  TextEditingController searchUsernameEditingController =
  TextEditingController();

  getMyInfoFromSharedPreference() async {
    myName = (await SharedPreferenceHelper().getDisplayName())!;
    myProfilePic = (await SharedPreferenceHelper().getUserProfileUrl())!;
    myUserName = (await SharedPreferenceHelper().getUserName())!;
    myEmail = (await SharedPreferenceHelper().getUserEmail())!;
    setState(() {});
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchBtnClick() async {
    isSearching = true;
    setState(() {});
    usersStream = await DatabaseMethods()
        .getUserByUserName(searchUsernameEditingController.text);

    setState(() {});
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatroomStream,
      builder: (context,AsyncSnapshot snapshot) {
        print(snapshot);
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return ChatRoomListTile(ds["lastMessage"], ds.id, myUserName!);
            })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget searchListUserTile({String? profileUrl, name, username, email}) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUsernames(myUserName!, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, username]
        };
        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(myUserName!, name)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(profileUrl!,height: 40,width: 40,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                return Icon(Icons.person_outline);
                },
              ),
              ),

            SizedBox(width: 12),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(name), Text(email)]),
            SizedBox(width :50)

          ],
        ),
      ),
    );
  }

  Widget searchUsersList() {
    return StreamBuilder(
      stream: usersStream,
      builder: (context,  snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: (snapshot.data! as QuerySnapshot).docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = (snapshot.data! as QuerySnapshot).docs[index];
            return searchListUserTile(
                profileUrl: ds["imgUrl"],
                name: ds["name"],
                email: ds["email"],
                username: ds["username"]);
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
  // getChatRooms2() async {
  //   chatRoomsStream2 =  DatabaseMethods().getChatRooms();
  //   return chatRoomsStream2;
  //
  // }

  getChatRooms() async {
    await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    await getMyInfoFromSharedPreference();
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded().whenComplete((){
      DatabaseMethods().getChatRooms().then((value){
        chatroomStream =value;
      });});
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Messenger Clone"),
      //   actions: [
      //     InkWell(
      //       onTap: () {
      //         AuthMethods().signOut().then((s) {
      //           Navigator.pushReplacement(
      //               context, MaterialPageRoute(builder: (context) => SignIn()));
      //         });
      //       },
      //       child: Container(
      //           padding: EdgeInsets.symmetric(horizontal: 16),
      //           child: Icon(Icons.exit_to_app)),
      //     )
      //   ],
      // ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Recent Chats",style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 40,fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
            // Row(
            //   children: [
            //     isSearching
            //         ? GestureDetector(
            //       onTap: () {
            //         isSearching = false;
            //         searchUsernameEditingController.text = "";
            //         setState(() {});
            //       },
            //       child: Padding(
            //           padding: EdgeInsets.only(right: 12),
            //           child: Icon(Icons.arrow_back)),
            //     )
            //         : Container(),
            //     Expanded(
            //       child: Container(
            //         margin: EdgeInsets.symmetric(vertical: 16),
            //         padding: EdgeInsets.symmetric(horizontal: 16),
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //                 color: Colors.grey,
            //                 width: 1,
            //                 style: BorderStyle.solid),
            //             borderRadius: BorderRadius.circular(24)),
            //         child: Row(
            //           children: [
            //             Expanded(
            //                 child: TextField(
            //                   controller: searchUsernameEditingController,
            //                   decoration: InputDecoration(
            //                       border: InputBorder.none, hintText: "username"),
            //                 )),
            //             GestureDetector(
            //                 onTap: () {
            //                   if (searchUsernameEditingController.text != "") {
            //                     onSearchBtnClick();
            //                   }
            //                 },
            //                 child: Icon(Icons.search))
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            isSearching ? searchUsersList() : chatRoomsList()
          ],
        ),
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, chatRoomId, myUsername;
  ChatRoomListTile(this.lastMessage, this.chatRoomId, this.myUsername);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String profilePicUrl = "", name = "", username = "";
  late Stream chatroomStream;


  getThisUserInfo() async {
    DatabaseMethods().getChatRooms().then((value){
      setState(() {
        chatroomStream =value;
      });
    });
    username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserInfo(username);
    print(
        "${querySnapshot.docs[0].id} ${querySnapshot.docs[0]["name"]}  ${querySnapshot.docs[0]["imgUrl"]}");
    name = "${querySnapshot.docs[0]["name"]}";
    profilePicUrl = "${querySnapshot.docs[0]["imgUrl"]}";


    setState(() {});
  }

  @override
  void initState() {
    super.initState();


    getThisUserInfo().whenComplete((){
      setState(() {});});



  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(username, name)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
        height: 60,
        decoration: BoxDecoration(color:Colors.orange[50],borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(profilePicUrl,height: 40,width: 40,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                  return Icon(Icons.person_outline);
                },
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                Text("${widget.lastMessage}")
              ],
            )
          ],
        ),
      ),
    );
  }
}


