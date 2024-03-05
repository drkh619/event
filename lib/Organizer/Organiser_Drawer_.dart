import 'package:event_management/Organizer/ChangeOrgPassword.dart';
import 'package:event_management/Organizer/infoBought.dart';
import 'package:event_management/Organizer/organizer_feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'About_Us.dart';
import 'faq.dart'; // Import the FAQ page
import 'Organizer_Login_Page.dart';

class Organiser_Drawer extends StatelessWidget {
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
                      "assets/event.png",
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
                      builder: (context) => ChangeOrgPasswordPage()));
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
                      builder: (context) => NotificationPage()));
            },
            leading: Icon(
              Icons.inbox,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.blueGrey.shade100
                  : Colors.blueGrey.shade900,
            ),
            title: Text("Ticket info",
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrgFeedbackPage())); // Navigate to FAQ page
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
              Organiser_Signout(context);
            },
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.blueGrey.shade100
                  : Colors.blueGrey.shade900,
            ),
            title: Text("Logout",
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
    await _CustomersharedPrefs.remove('organizer_id');

    // Navigator.pushAndRemoveUntil(
    //   ctx,
    //   MaterialPageRoute(builder: (ctx1) => Organizer_Login_Page()),
    //       (route) => false,
    // );
    print("logged out");
  }
}
