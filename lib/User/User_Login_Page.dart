import 'dart:convert';

import 'package:event_management/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'User_Home_Page.dart';
import 'User_Registration_Page.dart';

class User_Login_Page extends StatefulWidget {
  const User_Login_Page({Key? key}) : super(key: key);

  @override
  _User_Login_PageState createState() => _User_Login_PageState();
}

class _User_Login_PageState extends State<User_Login_Page> {

  getusername()async{

    final shrdprfs = await SharedPreferences.getInstance();
    await shrdprfs.setString("username_user", username_user);

  }


  getId()async{

    final shrdprfs = await SharedPreferences.getInstance();
    await shrdprfs.setString("userId_user", user_Id);

  }



  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Login',
          style: GoogleFonts.poppins(color: Colors.white,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 35,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100,),
            Form(
              key: formkey,
              child: Column(
                children: [
                  Image.asset(Theme.of(context).brightness == Brightness.dark ? 'assets/userdark.png' : 'assets/user.png', height: 100),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextFormField(
                      controller: username,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter username";
                        }
                        return null;
                      },
                      onSaved: (username) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Username',
                        hintText: 'Enter Username',
                      ),
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextFormField(
                      controller: password,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Password',
                        hintText: 'Enter secure password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.only(
                  left: 110,
                  right: 110,
                  top: 20,
                  bottom: 20,
                ),
              ),
              onPressed: () {
                user_Login();
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New User?',
                  style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                      , fontSize: 15),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => User_Registration_Page(),
                      ),
                    );
                  },
                  child: Text("Create Account"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future user_Login() async {
    if (formkey.currentState!.validate()) {
      var url = "$ip_address/Event_Management/User/user_login.php";
      var response = await http.post(Uri.parse(url), headers: {
        'Accept': 'application/json'
      }, body: {
        "username": username.text,
        "password": password.text,
      });

      var data = json.decode(response.body);
      if (data != null) {
        for (var singleUser in data) {
          final SharedPreferences sharedpreferences =
          await SharedPreferences.getInstance();

          await sharedpreferences.setString('user_id', singleUser["id"]);

          username_user = singleUser["username"];
          user_Id = singleUser["id"];

          getusername();
          getId();
        }

        final snackBar = SnackBar(
          content: Text('Login Successful'),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => User_HomePage(),
          ),
        );
      } else {
        final snackBar = SnackBar(
          content: Text('Username and password invalid'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

}
