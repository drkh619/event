import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:shared_preferences/shared_preferences.dart';


import '../Organizer/Display_Data_Online.dart';
import 'User_Login_Page.dart';

class User_HomePage extends StatefulWidget {
  const User_HomePage({Key? key}) : super(key: key);

  @override
  _User_HomePageState createState() => _User_HomePageState();
}

class _User_HomePageState extends State<User_HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("user Home Page"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Logout"),
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
          ],
        ),
      ),
    );
  }
}
