import 'dart:convert';

import 'package:event_management/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:password_strength/password_strength.dart';

import 'Organizer_Login_Page.dart';


class Organizer_Registration_Page extends StatefulWidget {
  const Organizer_Registration_Page({Key? key}) : super(key: key);

  @override
  _Organizer_Registration_PageState createState() => _Organizer_Registration_PageState();
}

class _Organizer_Registration_PageState extends State<Organizer_Registration_Page> {

  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  late bool status;

  late String message;

  double calculatePasswordStrength(String password) {
    double strength = estimatePasswordStrength(password);
    return strength;
  }

  Widget buildPasswordStrengthIndicator(String password) {
    double strength = calculatePasswordStrength(password);

    Color strengthColor;
    String strengthText;

    if (strength > 0.7) {
      strengthColor = Colors.green;
      strengthText = 'Strong';
    } else if (strength > 0.4) {
      strengthColor = Colors.orange;
      strengthText = 'Moderate';
    } else {
      strengthColor = Colors.red;
      strengthText = 'Weak';
    }

    return Row(
      children: [
        Text(
          strengthText,
          style: TextStyle(color: strengthColor,fontSize: 10.0,
            fontWeight: FontWeight.w300,),
        ),
      ],
    );
  }

  @override
  void initState() {
    _username = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
    _password = TextEditingController();
    _confirmpassword = TextEditingController();

    status = false;
    message = "";

    super.initState();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _obscurePassword = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up',
          style: TextStyle(color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Lottie.asset(Theme.of(context).brightness == Brightness.dark ? 'assets/logodark.json' : 'assets/logo.json', height: 150),
                SizedBox(height: 10,),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextFormField(
                      controller: _username,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a Username";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: "Username",
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                    ),
                ),
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter  email";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      onSaved: (email) {},
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                    )),
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextFormField(
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty && value!.length == 10) {
                          return "Please enter phone number";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                    )),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: TextFormField(
                    controller: _password,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a Password";
                      }
                      return null;
                    },
                    onSaved: (name) {},
                    obscureText: _obscurePassword, // Use a bool variable to control password visibility
                    decoration: InputDecoration(
                      labelText: 'Password',
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      // Add suffix icon to toggle password visibility
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left:282.0),
                  child: buildPasswordStrengthIndicator(_password.text),
                ),
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextFormField(
                      controller: _confirmpassword,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter re-password";
                        }
                        if (_password.text != _confirmpassword.text) {
                          return "Password Do not match";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                    )),
                SizedBox(height: 30),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: 'Registration successfull ',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blueGrey);
                      if (formkey.currentState!.validate()) {
                        setState(() {

                          Registration();
                        });
                        _username.clear();
                        _email.clear();
                        _phone.clear();
                        _password.clear();
                        _confirmpassword.clear();
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                ),),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Organizer_Login_Page()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),

            //],
          ),
        ),
      ),
    );
  }

  Future Registration() async {
    var APIURL = "http://$ip_address/Event_Management/Organise/organiser_Registration.php";

    //json maping user entered details
    Map mapeddate = {
      'username': _username.text,
      'email': _email.text,
      'phone': _phone.text,
      'password': _password.text
    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(APIURL), body: mapeddate);

    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    var responseMessage = data["message"];
    var responseError = data["error"];
    print("DATA: ${data}");
    if (responseError) {
      setState(() {
        status = false;
        message = responseMessage;
      });
      Fluttertoast.showToast(
          msg: 'email and password already exists try another! ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          webPosition: 1,
          backgroundColor: Colors.blueGrey);
    } else {
      _username.clear();
      _email.clear();
      _phone.clear();
      _password.clear();
      _confirmpassword.clear();

      setState(() {
        status = true;
        message = responseMessage;
      });

      Fluttertoast.showToast(
          msg: 'Registration successfull ',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey);
    }

    print("DATA: ${data}");
  }
}

