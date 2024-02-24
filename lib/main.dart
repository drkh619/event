import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Main Entrance/Main_Screen.dart';


var userid;

var user_Id;

var username_user;

var username_org;

var event_type;


// var ip_address ='192.168.29.104'; //integos
// var ip_address ='172.20.10.5'; //home-ethernet
var ip_address = 'http://192.168.18.85'; //home-wifi
// var ip_address = 'https://parietal-insanities.000webhostapp.com';
//var ip_address = 'ae68-103-175-89-0.ngrok-free.app';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.teal, // Define your primary color
        textTheme: TextTheme(
          bodyText1: GoogleFonts.poppins(color: Colors.black), // Text color in light mode
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.purple, // Define your primary color in dark mode
        textTheme: TextTheme(
          bodyText1: GoogleFonts.poppins(color: Colors.white), // Text color in dark mode
        ),
      ),
      themeMode: ThemeMode.system,
      home:MainScreen(),
    );
  }

}


