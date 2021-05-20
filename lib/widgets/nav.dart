import 'package:catalog_app/helper_functions/Authentication.dart';
import 'package:catalog_app/screens/add_product.dart';
import 'package:catalog_app/screens/home_page.dart';
import 'package:catalog_app/screens/products_page.dart';
import 'package:catalog_app/screens/sell.dart';
import 'package:catalog_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';


var tstyle = TextStyle(color: Colors.white.withOpacity(0.6),
    fontSize: 50
);

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var padding = EdgeInsets.symmetric(horizontal: 18,vertical: 5);
  double gap =10;

  int _index = 0;
  List<Color?> colors = [
    Colors.purple,
    Colors.pink,
    Colors.grey[600],
    Colors.teal
  ];

  final List<Widget> pages = [
    Homepage(),
    AddImage(),
    Seller(),
    ProductDisplay(),
  ];
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: MyDrawer(),
        extendBody: true,

        body:PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            children: pages,
            onPageChanged: (int index) {
              setState(() {
                controller.jumpToPage(index);
              });
            }),

        bottomNavigationBar: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: -10,
                    blurRadius: 60,
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(0,25),
                  )
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
              child: GNav(
                curve: Curves.easeInQuad,
                duration: Duration(milliseconds: 900),
                tabs: [
                  GButton(
                    gap: gap,
                    icon: LineIcons.home,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.purple,
                    text: 'Home',
                    textColor: Colors.purple,
                    backgroundColor: Colors.purple.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: LineIcons.heart,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.pink,
                    text: "My Ads",
                    textColor: Colors.pink,
                    backgroundColor: Colors.pink.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: LineIcons.search,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.grey,
                    text: 'Sell',
                    textColor: Colors.grey,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: LineIcons.user,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.teal,
                    text: 'Profile',
                    textColor: Colors.teal,
                    backgroundColor: Colors.teal.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                ],
                onTabChange: (index) {
                  controller.jumpToPage(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}