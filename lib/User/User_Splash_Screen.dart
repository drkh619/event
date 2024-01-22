import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../main.dart';
import 'User_Home_Page.dart';
import 'User_Login_Page.dart';

var key_value;
var User_key;

class User_Splash_Screen extends StatefulWidget {
  _User_Splash_ScreenState createState() => _User_Splash_ScreenState();
}

class _User_Splash_ScreenState extends State<User_Splash_Screen> {


  void initState() {
    getValidationData().whenComplete(() async {
      await Timer(Duration(seconds: 1), () {
        User_key == null
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => User_Login_Page()))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => User_HomePage()));
      });
    });
    setState(() {
      getusername();
      getuserId();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Lottie.asset(Theme.of(context).brightness == Brightness.dark ? 'assets/loadingdark.json' : 'assets/loading.json',), // Lottie animation
          ],
        ),
      ),
    );
  }


  Future getValidationData() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var obtainedemail = await sharedprefs.getString('user_id');
    setState(() {
      User_key = obtainedemail;
    });
  }


  getusername() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var obtainedemail = await sharedprefs.getString('username_user');
    setState(() {
      username_user = obtainedemail!;
    });

  }

  getuserId() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var obtainedemail = await sharedprefs.getString('userId_user');
    setState(() {
      user_Id = obtainedemail!;
    });

  }

}
