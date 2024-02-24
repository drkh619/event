import 'dart:convert';

import 'package:event_management/Organizer/Organizer_Home_Page.dart';
import 'package:event_management/Organizer/Organizer_Registration_Page.dart';
import 'package:event_management/Organizer/testpage.dart';
import 'package:event_management/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Organizer_Login_Page extends StatefulWidget {
  const Organizer_Login_Page({Key? key}) : super(key: key);

  @override
  _Organizer_Login_PageState createState() => _Organizer_Login_PageState();
}

class _Organizer_Login_PageState extends State<Organizer_Login_Page> {
  PageController controller = PageController(initialPage: 0);


  getID()async{
    final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();

    sharedpreferences.setString('organizer_uid',userid );

  }

  getusername()async{

    final shrdprfs = await SharedPreferences.getInstance();
    await shrdprfs.setString("username_org", username_org);

  }



  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organizer Login',
        style: TextStyle(color: Colors.white,
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
                  Lottie.asset(Theme.of(context).brightness == Brightness.dark ? 'assets/logodark.json' : 'assets/logo.json', height: 150),
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
                        hintText: 'Enter your Username',
                      ),
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
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
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                      ),
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
                organiser_Login();
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
                        builder: (context) => Organizer_Registration_Page(),
                        // builder: (context) => SingUpScreen(controller: null,),
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

  Future organiser_Login() async {
    var url = "$ip_address/Event_Management/Organise/organiser_login.php";
    print(url);
    var response =  await http.post(Uri.parse(url), headers: {
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

        await sharedpreferences.setString('organizer_id', singleUser["id"]);



        userid=singleUser["id"];
        username_org=singleUser["username"];

        getusername();
        getID();

      }

      final snackBar = SnackBar(
        content: Text('Login Successfull'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => OnboardingPage1(),
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
