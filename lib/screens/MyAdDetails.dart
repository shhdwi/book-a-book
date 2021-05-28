import 'dart:ui';

import 'package:catalog_app/services/Database.dart';
import 'package:catalog_app/services/product_data.dart';
import 'package:catalog_app/services/product_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class YourAdDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(
        context, listen: false);
    _onproductDeleted(ProductData productData){
      Navigator.pop(context);
      productNotifier.deletePro(productData);
    }
    return Scaffold(


      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5.0, horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                        children: [
                          Image.network(productNotifier.currentData.imgUrl, fit: BoxFit.fill,),
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                              child: Container(color: Colors.orangeAccent.withOpacity(0.1)),


                            ),
                          ),
                          Positioned.fill(

                            child: Padding(

                              padding: const EdgeInsets.all(60),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25)),

                                child: Card(




                                  child :Hero(tag:productNotifier.currentData.imgUrl,child: Image.network(productNotifier.currentData.imgUrl, fit: BoxFit.cover)),



                                ),
                              ),
                            ),
                          ),

                        ])




                ),



                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Text('Price: ₹ ${productNotifier.currentData.price}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  )),
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(const Radius.circular(20)),
                                  color: Color(0xFFFFEDD5)
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Text('Seller: ${productNotifier.currentData.name}',
                                overflow: TextOverflow.fade,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(const Radius.circular(20)),
                                color: Color(0xFFFFEDD5),
                              ),
                            ),

                          ]
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Text('Description: ${productNotifier.currentData.desc}',
                            style: TextStyle(
                                fontSize:18.0
                            ),),
                        ),
                      ),
                      Center(
                        child: Container(

                          padding: const EdgeInsets.all(0.0),

                          height: 40,
                          alignment: Alignment.center,
                          child: OutlinedButton.icon(

                            onPressed: ()
                              {deleteProduct(productNotifier.currentData, _onproductDeleted);}
                            ,
                            icon: Icon(CupertinoIcons.delete,
                                color: Colors.redAccent),
                            label: Text(
                              "Delete Ad from Sale",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,


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




                          ),


                        ),
                    ],

                  ),
                ),
              ],

            )
        ),
      ),


    );

  }
}