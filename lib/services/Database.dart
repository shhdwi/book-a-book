
import 'package:catalog_app/helper_functions/sharedpref_helper.dart';
import 'package:catalog_app/services/product_data.dart';
import 'package:catalog_app/services/product_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DatabaseMethods{


  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots();
  }

  Future addMessage(
      String chatRoomId, String messageId, Map<String,dynamic> messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessageSend(String chatRoomId, Map<String,dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map<String,dynamic> chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  // Future<List<QueryDocumentSnapshot<Object?>>> getChatRooms() async {
  //   String myUsername = (await SharedPreferenceHelper().getUserName())!;
  //   QuerySnapshot qn= await FirebaseFirestore.instance
  //       .collection("chatrooms")
  //       .orderBy("lastMessageSendTs", descending: true)
  //       .where("users", arrayContains: myUsername)
  //       .get();
  //   return qn.docs;
  // }
  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String myUsername = (await SharedPreferenceHelper().getUserName())!;
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: myUsername)
        .snapshots();
  }


  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }


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
Future getProducts(ProductNotifier productNotifier) async{
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("items").get();

  List<ProductData> productList = [];
  snapshot.docs.forEach((element) {
    print(element);
    ProductData data = ProductData.fromMap(element.data() as Map<String,dynamic>);
    productList.add(data);

  });
  productNotifier.productList =productList;
}

Future getAds(ProductNotifier productNotifier) async{
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("items").get();
  await SharedPreferenceHelper().getUserinfo().then((snap) {
    List<ProductData> adList = [];
    snapshot.docs.forEach((element) {
      ProductData Addata = ProductData.fromMap(
          element.data() as Map<String, dynamic>);
      if (Addata.email == snap["email"]) {
        adList.add(Addata);
      }
    });
    productNotifier.productList =adList;
  });
      }

Future getProduct(ProductNotifier productNotifier) async{
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("items").get();
  await SharedPreferenceHelper().getUserinfo().then((snap) {
    List<ProductData> adList = [];
    snapshot.docs.forEach((element) {
      ProductData Addata = ProductData.fromMap(
          element.data() as Map<String, dynamic>);
      if (Addata.email != snap["email"]) {
        adList.add(Addata);
      }
    });
    productNotifier.productList =adList;
  });
}
deleteProduct(ProductData productData,Function productDeleted) async{

   await FirebaseStorage.instance.refFromURL(productData.imgUrl).delete();

   await FirebaseFirestore.instance.collection("items").doc(productData.desc).delete();
   productDeleted(productData);
}









