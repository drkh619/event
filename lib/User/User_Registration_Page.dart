import 'dart:convert';

import 'package:event_management/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:password_strength/password_strength.dart';

import 'User_Login_Page.dart';




class User_Registration_Page extends StatefulWidget {
  const User_Registration_Page({Key? key}) : super(key: key);

  @override
  _User_Registration_PageState createState() => _User_Registration_PageState();
}

class _User_Registration_PageState extends State<User_Registration_Page> {

  TextEditingController _username = TextEditingController();

  TextEditingController _email = TextEditingController();

  TextEditingController _phone = TextEditingController();

  TextEditingController _password = TextEditingController();

  TextEditingController _confirmpassword = TextEditingController();

  FocusNode _passwordFocus = FocusNode();

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

  bool _isPasswordValid = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _hasPasswordOneUpperAndSymbol = false;


  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final uppercaseRegex = RegExp(r'[A-Z]');
    final symbolRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) _hasPasswordOneNumber = true;

      _hasPasswordOneUpperAndSymbol = false;
      if (uppercaseRegex.hasMatch(password) &&
          symbolRegex.hasMatch(password)) {
        _hasPasswordOneUpperAndSymbol = true;
      }
      _isPasswordValid = _isPasswordEightCharacters &&
          _hasPasswordOneNumber &&
          _hasPasswordOneUpperAndSymbol;
    });
  }


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
                // Padding(
                //   padding: EdgeInsets.only(left: 26.0,right: 26.0,top: 50.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: <Widget>[
                //       Padding(
                //         padding: const EdgeInsets.all(12.0),
                //         child: Text(
                //           'Register',
                //           style: TextStyle(
                //             color: Theme
                //                 .of(context)
                //                 .brightness == Brightness.dark
                //                 ? Colors.white
                //                 : Colors.black,
                //             fontSize: 30,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //       CloseButton()
                //     ],
                //   ),
                // ),
                SizedBox(height: 30,),
                Image.asset(Theme.of(context).brightness == Brightness.dark ? 'assets/userdark.png' : 'assets/user.png', height: 90),
                SizedBox(height: 20,),
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
                        label: Text("Username"),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        label: Text("Email"),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
                        label: Text("Phone"),
                        prefix: Text("+91 "),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                    )),
                SizedBox(height: 20),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 40,
                //   ),
                //   child: TextFormField(
                //     controller: _password,
                //     keyboardType: TextInputType.text,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Please enter a Password";
                //       }
                //       return null;
                //     },
                //     onSaved: (name) {},
                //     obscureText: _obscurePassword, // Use a bool variable to control password visibility
                //     decoration: InputDecoration(
                //       labelText: 'Password',
                //       contentPadding:
                //       EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                //         borderSide: BorderSide(
                //           color: Colors.grey.shade500,
                //         ),
                //       ),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                //         borderSide: BorderSide(
                //           color: Colors.grey.shade500,
                //         ),
                //       ),
                //       // Add suffix icon to toggle password visibility
                //       suffixIcon: GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             _obscurePassword = !_obscurePassword;
                //           });
                //         },
                //         child: Icon(
                //           _obscurePassword
                //               ? Icons.visibility
                //               : Icons.visibility_off,
                //         ),
                //       ),
                //     ),
                //     style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                //   ),
                // ),
                // SizedBox(height: 5),
                // Padding(
                //   padding: const EdgeInsets.only(left:282.0),
                //   child: buildPasswordStrengthIndicator(_password.text),
                // ),
                // SizedBox(height: 20),
                // Padding(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 40,
                //     ),
                //     child: TextFormField(
                //       controller: _confirmpassword,
                //       keyboardType: TextInputType.text,
                //       obscureText: true,
                //       validator: (value) {
                //         if (value!.isEmpty) {
                //           return "Please enter re-password";
                //         }
                //         if (_password.text != _confirmpassword.text) {
                //           return "Password Do not match";
                //         }
                //         return null;
                //       },
                //       onSaved: (name) {},
                //       decoration: InputDecoration(
                //         label: Text("Confirm password"),
                //         contentPadding:
                //         EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                //         enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(10)),
                //           borderSide: BorderSide(
                //             // color: Colors.grey[400],
                //             color: Colors.grey.shade500,
                //           ),
                //         ),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(10)),
                //             borderSide: BorderSide(
                //               color: Colors.grey.shade500,
                //             )),
                //       ),
                //       style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                //     )),
                // SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: TextFormField(
                          controller: _password,
                          keyboardType: TextInputType.text,
                          focusNode: _passwordFocus,
                          onChanged: (password) {
                            onPasswordChanged(password);
                          },
                          onTap: () => _scrollToField(_passwordFocus),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a Password";
                            }
                            return null;
                          },
                          onSaved: (name) {},
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
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
                          style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
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
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: _isPasswordEightCharacters
                              ? Colors.green
                              : Colors.transparent,
                          border: _isPasswordEightCharacters
                              ? Border.all(color: Colors.transparent)
                              : Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Icon(Icons.check,
                              color: Colors.white, size: 15),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("Contains at least 8 characters"),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: _hasPasswordOneNumber
                              ? Colors.green
                              : Colors.transparent,
                          border: _hasPasswordOneNumber
                              ? Border.all(color: Colors.transparent)
                              : Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Icon(Icons.check,
                              color: Colors.white, size: 15),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("Contains at least 1 number"),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: _hasPasswordOneUpperAndSymbol
                              ? Colors.green
                              : Colors.transparent,
                          border: _hasPasswordOneUpperAndSymbol
                              ? Border.all(color: Colors.transparent)
                              : Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Icon(Icons.check,
                              color: Colors.white, size: 15),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("Contains at least 1 Uppercase and Symbol"),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: _isPasswordValid
                        ? () {
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
                    } : null,
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
                                builder: (context) => User_Login_Page()));
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

  Future<void> Registration() async {
    var APIURL = "$ip_address/Event_Management/User/user_Registration.php";

    // Json mapping user entered details
    Map<String, String> mappedData = {
      'username': _username.text,
      'email': _email.text,
      'phone': _phone.text,
      'password': _password.text
    };

    // Send data using HTTP post to our PHP code
    final response = await http.post(Uri.parse(APIURL), body: mappedData);

    // Getting response from PHP code
    final data = jsonDecode(response.body);
    final responseError = data["error"] ?? true; // Assume error by default
    final responseMessage = data["message"] ?? "Unknown error";

    if (!responseError) {
      // Registration successful
      setState(() {
        status = true;
        message = responseMessage;
      });

      // Clear text fields
      _username.clear();
      _email.clear();
      _phone.clear();
      _password.clear();
      _confirmpassword.clear();

      Fluttertoast.showToast(
        msg: 'Registration successful',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
      );
    } else {
      // Registration failed
      setState(() {
        status = false;
        message = responseMessage;
      });

      Fluttertoast.showToast(
        msg: 'Registration failed: $message',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
      );
    }
  }

  void _scrollToField(FocusNode focusNode) {
    Scrollable.ensureVisible(focusNode.context!,
        duration: Duration(milliseconds: 300));
  }
}