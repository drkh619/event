import 'package:event_management/Organizer/Display_Data_Offline.dart';
import 'package:event_management/Organizer/Display_Data_Online.dart';
import 'package:event_management/Organizer/analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'Organiser_Drawer_.dart';
import 'Organizer_Login_Page.dart';
import 'Create_online_event.dart';
import 'Create_offline_event.dart';
import 'Display_Data_Online.dart';
// import 'Display_Data_Offline.dart';

class Organizer_HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Organizer Home Page"),
       // title: Text(userid),
        title: userid == null ? SizedBox() :Text("Organiser Homepage", style: TextStyle(color: Colors.white),),
        // userid
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () async {
              final SharedPreferences sharedpreferences =
              await SharedPreferences.getInstance();
              sharedpreferences.remove('organizer_id');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Organizer_Login_Page(),
                ),
              );
            },
            icon: Icon(Icons.exit_to_app,color: Colors.white
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Organiser_Drawer(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Stack(
                        children: [
                          Lottie.asset(Theme.of(context).brightness == Brightness.dark ? 'assets/backandark.json' : 'assets/backan.json',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.contain),
                          Container(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Select Type of Event',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Create_online_event(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Online Event',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      minimumSize: Size(150, 50),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Create_offline_event(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Offline Event',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      minimumSize: Size(150, 50),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    elevation: 0,
                  );
                },
                child: Container(
                  width: 300,
                  height: 190,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Lottie.asset(
                        Theme.of(context).brightness == Brightness.dark
                            ? 'assets/animatedark.json'
                            : 'assets/animate2.json',
                        height: 70,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Create an Event',
                        style: GoogleFonts.lobster(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  elevation: 9,
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "My Events",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                  ),
                ),
              ),
              // Add the grid here
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Display_Data_Online()));
                          },
                          child: CustomGridItem("grid1", "Online Event", Theme.of(context).primaryColor, Theme.of(context).brightness == Brightness.dark ? 'assets/onlineeventdark.json' : 'assets/onlineevent.json')),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Display_Data_Offline()));
                          },
                          child: CustomGridItem("grid2", "Offline Event", Theme.of(context).primaryColor,Theme.of(context).brightness == Brightness.dark ? 'assets/createdondark.json' : 'assets/createdon.json',)),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AnalyticsPage()));
                          },
                          child: CustomGridItem("grid3", "Analytics", Theme.of(context).primaryColor,Theme.of(context).brightness == Brightness.dark ? 'assets/analytics_dark.json' : 'assets/analytics_light.json')),
                      CustomGridItem("grid4", "Expense", Theme.of(context).primaryColor,'assets/displaydata.json'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomGridItem(String tag, String title, Color color, String animationAsset,) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              animationAsset,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              // alignment: Alignment.center,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

