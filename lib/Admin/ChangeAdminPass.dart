import 'dart:convert';
import 'package:event_management/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeAdmPasswordPage extends StatefulWidget {
  @override
  _ChangeAdmPasswordPageState createState() => _ChangeAdmPasswordPageState();
}

class _ChangeAdmPasswordPageState extends State<ChangeAdmPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _isPasswordValid = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _hasPasswordOneUpperAndSymbol = false;
  String adminName = '';

  void _retrieveAdminName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      adminName = prefs.getString('admin_name') ?? '';
      prefs.setString('admin_name', adminName);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password',style: GoogleFonts.poppins(),),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _oldPasswordController,
                keyboardType: TextInputType.text,
                onChanged: onPasswordChanged,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the old password';
                  }
                  return null;
                },
                obscureText: _obscureOldPassword,
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  labelStyle: TextStyle(color: Colors.grey), // Change label text color if needed
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple.shade800),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureOldPassword = !_obscureOldPassword;
                      });
                    },
                    child: Icon(
                      _obscureOldPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _newPasswordController,
                keyboardType: TextInputType.text,
                onChanged: onPasswordChanged,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the new password';
                  }
                  if (!_isPasswordEightCharacters) {
                    return 'Password must contain at least 8 characters';
                  }
                  if (!_hasPasswordOneNumber) {
                    return 'Password must contain at least 1 number';
                  }
                  if (!_hasPasswordOneUpperAndSymbol) {
                    return 'Password must contain at least 1 uppercase letter and symbol';
                  }
                  return null;
                },
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(color: Colors.grey), // Change label text color if needed
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple.shade800),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                    child: Icon(
                      _obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _changePassword();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor, // Background color
                    onPrimary: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Button padding
                  ),
                  child: Text(
                    'Change Password',
                    style: GoogleFonts.poppins(
                      fontSize: 16, // Text size
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _isPasswordEightCharacters ? Colors.green : Colors.transparent,
                        border: _isPasswordEightCharacters ? Border.all(color: Colors.transparent) : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Icon(Icons.check, color: Colors.white, size: 15),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: Text("Contains at least 8 characters",style: GoogleFonts.poppins(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),)),
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
                        color: _hasPasswordOneNumber ? Colors.green : Colors.transparent,
                        border: _hasPasswordOneNumber ? Border.all(color: Colors.transparent) : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Icon(Icons.check, color: Colors.white, size: 15),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text("Contains at least 1 number",style: GoogleFonts.poppins(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),),
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
                        color: _hasPasswordOneUpperAndSymbol ? Colors.green : Colors.transparent,
                        border: _hasPasswordOneUpperAndSymbol ? Border.all(color: Colors.transparent) : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Icon(Icons.check, color: Colors.white, size: 15),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: Text("Contains at least 1 Uppercase and Symbol",style: GoogleFonts.poppins(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final uppercaseRegex = RegExp(r'[A-Z]');
    final symbolRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) _hasPasswordOneNumber = true;

      _hasPasswordOneUpperAndSymbol = false;
      if (uppercaseRegex.hasMatch(password) && symbolRegex.hasMatch(password)) {
        _hasPasswordOneUpperAndSymbol = true;
      }
      _isPasswordValid = _isPasswordEightCharacters && _hasPasswordOneNumber && _hasPasswordOneUpperAndSymbol;
    });
  }

  Future<void> _changePassword() async {
    final String url = "$ip_address/Event_Management/Admin/change_password.php";

    final response = await http.post(
      Uri.parse(url),
      body: {
        "old_password": _oldPasswordController.text,
        "new_password": _newPasswordController.text,
        "username":'admin',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['error']) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(responseData['message']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content:Column(
                mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildLottieAnimation(),
                  SizedBox(height: 16), // Add some space between the animation and text
                  Text('Your password has changed successfully!'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Handle other status codes as needed
      print('Error: ${response.reasonPhrase}');
    }
  }

  Widget buildLottieAnimation() {
    return Container(
      height: 200, // Adjust the height as needed
      width: 200, // Adjust the width as needed
      child: Lottie.asset('assets/thank.json'),
    );
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
}
