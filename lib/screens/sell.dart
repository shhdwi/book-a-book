import 'dart:io';
import 'package:catalog_app/helper_functions/sharedpref_helper.dart';
import 'package:catalog_app/screens/add_product.dart';
import 'package:catalog_app/services/Database.dart';
import 'package:catalog_app/services/auth.dart';
import 'package:catalog_app/utils/routes.dart';
import 'package:catalog_app/widgets/nav.dart';
import 'package:catalog_app/widgets/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

import 'display_page.dart';
import 'home_page.dart';

class Seller extends StatefulWidget {



  @override
  _SellerState createState() => _SellerState();
}

class _SellerState extends State<Seller> {
  Reference? ref;


  List<File> _image = [];
  final picker = ImagePicker();


  final formKey1 = GlobalKey<FormState>();
  TextEditingController titleTextEditingController = new TextEditingController();
  TextEditingController descTextEditingController = new TextEditingController();
  TextEditingController priceTextEditingController = new TextEditingController();
  Future UploadItem(
      Map<String, dynamic> ItemInfo) async{
    print(ItemInfo);
    return FirebaseFirestore.instance
        .collection("items")
        .add(ItemInfo);

  }

  UploadIt() async{

    if (formKey1.currentState!.validate()&& _image[0]!=null){
      UploadImage();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: formKey1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/upload.png", fit: BoxFit.scaleDown),

                  TextFormField(
                    controller: titleTextEditingController,
                    decoration: InputDecoration(
                      hintText: "Ad Title",
                      labelText: "Ad Title",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ad Title cannot be Empty";
                      }
                      if (value.length > 15) {
                        return "Ad Title cannot be more than 15 characters";
                      }

                      return null;
                    },

                  ),
                  TextFormField(
                    controller: descTextEditingController,
                    decoration: InputDecoration(
                      hintText: "Description",
                      labelText: "Describe what you are selling",
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 10) {
                        return "Description cannot be less than 10 characters";
                      }
                      return null;
                    },

                  ),
                  TextFormField(
                    controller: priceTextEditingController,
                    decoration: InputDecoration(
                      hintText: "Price",
                      labelText: "Set your Price",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Price cannot be empty";
                      }
                      if (value.length > 5) {
                        return "Price cannot be higher than 9999";
                      }
                      return null;
                    },
                    
                  ),
                  SizedBox(height:5,),
                  Card(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: _image.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context, index){
                      return index == 0
                          ? Center(
                        child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              return
                             chooseImage();}
                      )
                      )
                          :Container(

                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(_image[index-1]),
                                fit: BoxFit.cover)),
                      );

                    }),
                  ),
                  OutlinedButton.icon(

                    onPressed: () {UploadIt();},
                    icon: FaIcon(FontAwesomeIcons.upload,
                        color: Colors.deepOrangeAccent),
                    label: Text(
                      "Sell your Book",
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 15,


                        fontFamily: "Poppins",

                        // fontWeight: FontWeight.bold,
                      ),

                    ),
                    style: OutlinedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)))
                    ),


                  ),
                  SizedBox(height: 40,)






                  
                  


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  chooseImage() async {

    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 50);
    setState(() {
      if (_image.length>0){_image.removeLast();}
      _image.add(File(pickedFile!.path));
    });
     if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }
  Future UploadImage() async{
    var img =_image[0];
    ref = FirebaseStorage.instance.ref().child('images/${Path.basename(img.path)}');
    await ref!.putFile(img).whenComplete(() async{
    await ref!.getDownloadURL().then((value)async{
    await SharedPreferenceHelper().getUserinfo().then((snapshot){

      Map<String, dynamic> itemInfo = {
        "name":snapshot["name"],
        "email":snapshot["email"],
        "desc": descTextEditingController.text,
        "imageurl": value,
        "price": priceTextEditingController.text,
        "title": titleTextEditingController.text};
        UploadItem(itemInfo);
      });
    });
  });




}
}
