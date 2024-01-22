import 'package:event_management/Admin/reported_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'Login_Page.dart';
import 'manage_organiser2.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Home Page"),
      ),
      drawer: Drawer(
        // backgroundColor: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [

            SizedBox(height: 70,),

            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Customer Rating '),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //             Admin_View_Customer_Rating()));


                //Contractor_worker_update_Display_Page
              },
            ),

          ],  ),
      ),
      // backgroundColor: Colors.blueGrey.shade100,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Cust_Search_Bar(),


            InkWell(
              onTap: () {
                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReportedEventsPage(), // Replace with the actual class for reported events page
                                  ),
                                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    children: [
                      Lottie.asset(
                        "assets/reported.json",
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                        top: 15,
                        left: 45,
                        child: Text(
                          "Reported Event",
                          style: GoogleFonts.courgette(
                              fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  shadowColor: Colors.purple.shade900,
                  elevation: 9,
                  margin: EdgeInsets.all(10),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => manage_organiser2(), // Replace with the actual class for reported events page
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    children: [
                      Lottie.asset(
                        "assets/manage.json",
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                        top: 15,
                        left: 45,
                        child: Text(
                          "Manage Organisers",
                          style: GoogleFonts.courgette(
                              fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  shadowColor: Colors.purple.shade900,
                  elevation: 9,
                  margin: EdgeInsets.all(10),
                ),
              ),
            ),



          ],
        ),
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: 50,
      //       ),
      //       TextButton(
      //           onPressed: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => ReportedEventsPage(), // Replace with the actual class for reported events page
      //               ),
      //             );
      //           },
      //           child: Text(
      //             'Reported Events',
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 16.0,
      //             ),
      //           ),),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           Text("Logout"),
      //           IconButton(
      //               onPressed: () async {
      //                 final SharedPreferences sharedpreferences =
      //                     await SharedPreferences.getInstance();
      //                 sharedpreferences.remove('admin_id');
      //                 Navigator.pushReplacement(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => Login_Page()));
      //               },
      //               icon: Icon(Icons.exit_to_app)),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
