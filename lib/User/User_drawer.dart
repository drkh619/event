import 'package:event_management/User/User_Login_Page.dart';
import 'package:event_management/User/changePassword.dart';
import 'package:event_management/User/user_feedback.dart';
import 'package:event_management/User/yourOrders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Organizer/About_Us.dart';
import '../Organizer/faq.dart';
import '../main.dart';

class User_Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 90.0,
                    backgroundImage: AssetImage(
                      "assets/logo.png",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "EVENT.IO",
                      style: GoogleFonts.alexandria(
                        color: Colors.purple.shade500,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => YourOrdersPage(uid: user_Id)));
            },
            leading: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.blueGrey.shade100
                  : Colors.blueGrey.shade900,
            ),
            title: Text("Your Orders",
                style: GoogleFonts.prompt(
                  fontSize: 15,
                )),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => About_Us()));
            },
            leading: Icon(
              Icons.apps,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.blueGrey.shade100
                  : Colors.blueGrey.shade900,
            ),
            title: Text("About",
                style: GoogleFonts.prompt(
                  fontSize: 15,
                )),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordPage()));
            },
            leading: Icon(
              Icons.password,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.blueGrey.shade100
                  : Colors.blueGrey.shade900,
            ),
            title: Text("Change Password",
                style: GoogleFonts.prompt(
                  fontSize: 15,
                )),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FAQPage())); // Navigate to FAQ page
            },
            leading: Icon(
              Icons.help, // Use the help icon for FAQ
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.blueGrey.shade100
                  : Colors.blueGrey.shade900,
            ),
            title: Text("FAQ", // Add a link to FAQ
                style: GoogleFonts.prompt(
                  fontSize: 15,
                )),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeedbackPage())); // Navigate to FAQ page
            },
            leading: Icon(
              Icons.feedback, // Use the help icon for FAQ
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.blueGrey.shade100
                  : Colors.blueGrey.shade900,
            ),
            title: Text("Feedback", // Add a link to FAQ
                style: GoogleFonts.prompt(
                  fontSize: 15,
                )),
          ),
          ListTile(
            onTap: () {
              Organiser_Signout(context);
            },
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.blueGrey.shade100
                  : Colors.blueGrey.shade900,
            ),
            title: Text("Log out",
                style: GoogleFonts.prompt(
                  fontSize: 15,
                )),
          ),
        ],
      ),
    );
  }

  Organiser_Signout(BuildContext ctx) async {
    final _CustomersharedPrefs = await SharedPreferences.getInstance();
    await _CustomersharedPrefs.remove('user_id');

    Navigator.pushAndRemoveUntil(
      ctx,
      MaterialPageRoute(builder: (ctx1) => User_Login_Page()),
          (route) => false,
    );
    print("logged out");
  }

}
