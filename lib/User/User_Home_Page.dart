import 'package:event_management/User/User_drawer.dart';
import 'package:event_management/User/parallax_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'package:shared_preferences/shared_preferences.dart';


import '../Organizer/Display_Data_Online.dart';
import '../Organizer/Organiser_Drawer_.dart';
import 'User_Login_Page.dart';

class User_HomePage extends StatefulWidget {
  const User_HomePage({Key? key}) : super(key: key);


  @override
  _User_HomePageState createState() => _User_HomePageState();
}

class _User_HomePageState extends State<User_HomePage> {
  static const images = <String>[
    'assets/delhi.jpg',
    'assets/hyderabad.jpg',
    'assets/kerala.jpg',
    'assets/mumbai.jpg',
    'assets/goa.jpg'
  ];
  static const customTexts = [
    'Delhi',
    'Hyderabad',
    'Kerala',
    'Mumbai',
    'Goa',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Organizer Home Page"),
        // title: Text(userid),
        centerTitle: true,
        title: Text("Homepage", style: TextStyle(color: Colors.white),),
        // userid
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () async {
                final SharedPreferences sharedpreferences =
                await SharedPreferences.getInstance();
                sharedpreferences.remove('user_id');
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => User_Login_Page()));
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      drawer: Drawer(
        child: User_Drawer(),
      ),
      body: Center(
        // child: ExampleParallax(),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 200,
              child: ParallaxSwiper(
                // List of image URLs to display
                images: images,
                // Fraction of the viewport for each image
                viewPortFraction: 0.85,
                // Disable the background zoom effect
                backgroundZoomEnabled: false,
                // Disable the foreground fade effect
                foregroundFadeEnabled: false,
                customTexts: customTexts,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
