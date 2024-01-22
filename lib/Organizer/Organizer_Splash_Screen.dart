import 'dart:async';

import 'package:event_management/Organizer/Organizer_Home_Page.dart';
import 'package:event_management/Organizer/Organizer_Login_Page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';




var key_value;
var Organizer_key;



class Organizer_Splash_Screen extends StatefulWidget {
  _Organizer_Splash_ScreenState createState() => _Organizer_Splash_ScreenState();
}

class _Organizer_Splash_ScreenState extends State<Organizer_Splash_Screen> {


  void initState() {
    getValidationData().whenComplete(() async {
      await Timer(Duration(seconds: 1), () {
        Organizer_key == null
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Organizer_Login_Page()))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Organizer_HomePage()));
      });
    });
    setState(() {

      Getid();
      getusername();
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
    var obtainedemail = await sharedprefs.getString('organizer_id');
    setState(() {
      Organizer_key = obtainedemail;
    });

  }


  Future Getid() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var obtain_uid = await sharedprefs.getString('organizer_uid');
    setState(() {
      userid = obtain_uid;
    });

  }

  getusername() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var obtainedemail = await sharedprefs.getString('username_org');
    setState(() {
      username_org = obtainedemail!;
    });

  }

}
