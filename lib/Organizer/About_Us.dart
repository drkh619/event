import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _url = 'https://eventio.drkh619.repl.co/';
//final Uri _url = Uri.parse('https://www.astrasoftwaresolutions.com');
final phoneNumber = '+91 0895450639';
final url = 'sms:$phoneNumber';
final facebook =
    "https://www.facebook.com/abhinand.nmurali";
final instagram =
    "https://www.instagram.com/abhi.nand.n";

void openwhatsapp() async {
  var whatsap = "+91 9496798234";
  var whatsapURL_android = "whatsapp://send?phone=" + whatsap + "&text=hello";
  var whatsap_Ios = "https://wa.me/$whatsap?text=${Uri.parse("hello")}";
  if (Platform.isIOS) {
    if (!await launch(
      whatsap_Ios,
    ))
      throw 'Could not launch $_url';
    else {
      SnackBar(content: new Text("whatsapp no installed"));
    }
  } else {
    if (!await launch(
      whatsapURL_android,
    ))
      throw 'Could not launch $_url';
    else {
      SnackBar(content: new Text("whatsapp no installed"));
    }
  }
}

void _launchPhone() async {
  if (!await launch(
    url,
  )) throw 'Could not launch $_url';
}

void _launchfacebook() async {
  if (!await launch(
    facebook,
    forceWebView: false,
    enableJavaScript: true,
  )) throw 'Could not launch $_url';
}

void _launchinstagram() async {
  if (!await launch(
    instagram,
    forceWebView: false,
    enableJavaScript: true,
  )) throw 'Could not launch $_url';
}

void _launchUrl() async {
  if (!await launch(
    _url, forceWebView: false,
    //forceSafariVC: false,
    enableJavaScript: true,
  )) throw 'Could not launch $_url';
}

class About_Us extends StatefulWidget {
  const About_Us({Key? key}) : super(key: key);

  @override
  State<About_Us> createState() => _About_UsState();
}

class _About_UsState extends State<About_Us> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(flex: 2, child: Container(color: Theme.of(context).brightness == Brightness.dark ? Colors.purple.shade500 : Colors.teal.shade500)),
            Expanded(child: Container(color: Theme.of(context).brightness == Brightness.dark ? Color(0xFF121212) : Colors.white)),
          ],
        ),
        Align(
          alignment: Alignment(0, 0.2),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 1.2,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 12,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Lottie.asset(
                        Theme.of(context).brightness == Brightness.dark ? 'assets/logodark.json' : 'assets/logo.json',
                        height: 150,
                        width: 150,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "EVENT.IO",
                          style: GoogleFonts.alexandria(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          'Welcome to EVENT.IO, the ultimate app for event booking and registration. Whether you are an event organizer or an attendee, our app will make your event experience easier, smoother, and more enjoyable. With our app, you can:\n\n'
                          '• Discover a variety of events based on your interests,location,and preferences.\n'
                          '• Explore detailed event information,such as descriptions,locations,dates and speakers.\n'
                          '• Register for events with multiple ticket options and secure payment processing.\n'
                          '• Save your registration details and access them anytime.\n'
                          '• Share events with your friends and family on social media platforms.\n'
                          '• Receive notifications and reminders about important updates and changes related to your registered events.\n'
                          '• Provide feedback and reviews for the events you attend, and see what others have to say.\n'
                          '• Integrate your events with your calendar platforms, so you never miss an event.\n\n'
                          'Our app is designed to cater to a diverse range of events, such as conferences, workshops, seminars, concerts, exhibitions, and more. No matter what type of event you are looking for or organizing, our app will help you find it or create it.'
                          'Our app is powered by a team of passionate developers who are committed to providing the best event booking and registration experience for our users. We are always open to feedback and suggestions, so feel free to contact us anytime. We hope you enjoy using our app as much as we enjoy creating it. Thank you for choosing EVENT.IO!🙏'
                          ,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15,
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextButton(
                          onPressed: _launchUrl,
                          //  _launchUrl;

                          child: Text(
                            "https://eventio.drkh619.repl.co/",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/phone.png",
                            height: 20,
                            width: 20,
                          ),
                          // SizedBox(
                          //   width: 12,
                          // ),
                          // Image.asset(
                          //   "assets/chat.png",
                          //   height: 20,
                          //   width: 20,
                          // ),
                          // SizedBox(
                          //   width: 12,
                          // ),
                          TextButton(
                            onPressed: _launchPhone,
                            child: Text("+91 9496798234"),
                          )
                          //
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: openwhatsapp,
                              child: Image.asset(
                                "assets/whatsapp.png",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            GestureDetector(
                              onTap: _launchinstagram,
                              child: Image.asset(
                                "assets/instagram.png",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            GestureDetector(
                              onTap: _launchfacebook,
                              child: Image.asset(
                                "assets/facebook.png",
                                height: 35,
                                width: 35,
                              ),
                            ),
                            GestureDetector(
                              onTap: ()async {
                                var result = await OpenMailApp.openMailApp();
                                if (!result.didOpen && !result.canOpen) {
                                  showNoMailAppsDialog(context);
                                } else if (!result.didOpen && result.canOpen) {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return MailAppPickerDialog(
                                        mailApps: result.options,
                                      );
                                    },
                                  );
                                }
                              },
                              child: Image.asset(
                                "assets/email.png",
                                height: 35,
                                width: 35,
                              ),
                            ),

                          ]),
                      SizedBox(
                        height: 30,
                      )
                      // RaisedButton(
                      //   child: Text("Open Mail App"),
                      //   onPressed: () async {
                      //     var result = await OpenMailApp.openMailApp();
                      //     if (!result.didOpen && !result.canOpen) {
                      //       showNoMailAppsDialog(context);
                      //     } else if (!result.didOpen && result.canOpen) {
                      //       showDialog(
                      //         context: context,
                      //         builder: (_) {
                      //           return MailAppPickerDialog(
                      //             mailApps: result.options,
                      //           );
                      //         },
                      //       );
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
