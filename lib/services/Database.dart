import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseMethods{
  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
    }
  Future UploadItem(
      String userId, Map<String, dynamic> ItemInfo)async{
    return FirebaseFirestore.instance
        .collection("items")
        .doc(userId)
        .set(ItemInfo);

  }

  }






