import 'package:catalog_app/helper_functions/sharedpref_helper.dart';
import 'package:catalog_app/model/user.dart';
import 'package:catalog_app/screens/home_page.dart';
import 'package:catalog_app/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser(){
    return _auth.currentUser;
  }

  UserData? _userFromFirebaseUser(User user){
    return user != null ? UserData(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      User? firebaseUser = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }
  Future signUpwithEmailandPassword(String email,String password) async{

    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser =result.user;
      return _userFromFirebaseUser(firebaseUser!);


    }catch(e){
      print(e.toString());

    }
  }
  Future resetPass(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());

    }
  }

  signInWithGoogle(BuildContext context) async{
    final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn =GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = (await _googleSignIn.signIn())!;
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    UserCredential result= await _firebaseAuth.signInWithCredential(credential);
    User userDetails = result.user!;
    if (result != null) {
      SharedPreferenceHelper().saveUserEmail(userDetails.email!);
      SharedPreferenceHelper().saveUserId(userDetails.uid);
      SharedPreferenceHelper()
          .saveUserName(userDetails.email!.replaceAll("@gmail.com", ""));
      SharedPreferenceHelper().saveDisplayName(userDetails.displayName!);
      SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL!);

      Map<String, dynamic> userInfoMap = {
        "email": userDetails.email,
        "username": userDetails.email!.replaceAll("@gmail.com", ""),
        "name": userDetails.displayName,
        "imgUrl": userDetails.photoURL
      };
      DatabaseMethods().addUserInfoToDB(userDetails.uid, userInfoMap).then(
          (value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage()));

          }
      );

  }
    Future signOut() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      await _auth.signOut();
    }
  }

  Future SignOut() async{
    try{
      return await _auth.signOut();

    }catch(e){
      print(e.toString());
    }
  }
}