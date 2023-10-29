import 'package:flutter/material.dart';

import 'Main Entrance/Main_Screen.dart';


var userid;


//var ip_address ='192.168.29.104'; //integos
//var ip_address ='192.168.18.52'; //home-ethernet
var ip_address ='192.168.18.73'; //home-wifi

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.teal, // Define your primary color
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black), // Text color in light mode
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.purple, // Define your primary color in dark mode
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white), // Text color in dark mode
        ),
      ),
      themeMode: ThemeMode.system,
      home:MainScreen(),
    );
  }

}


