import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:event_management/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:event_management/main.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportedEventModel {
  final String id;
  final String eventName;
  final String eventDate;
  final String status;
  final String event_venue;

  ReportedEventModel({
    required this.id,
    required this.eventName,
    required this.eventDate,
    required this.status,
    required this.event_venue,

  });
}

class ReportedEventsPage extends StatefulWidget {
  @override
  _ReportedEventsPageState createState() => _ReportedEventsPageState();
}

class _ReportedEventsPageState extends State<ReportedEventsPage> {
  Future<List<ReportedEventModel>> getReportedEvents() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var organizerUid = await sharedPrefs.getString('organizer_uid');
    String url = "$ip_address/Event_Management/Admin/reported_events.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    List<ReportedEventModel> reportedEvents = [];
    for (var event in responseData) {
      ReportedEventModel reportedEvent = ReportedEventModel(
        id: event["id"].toString(),
        eventName: event["event_name"].toString(),
        eventDate: event["event_start_date"].toString(),
        status: event["status"].toString(),
        event_venue: event["event_venue"].toString(),
      );

      reportedEvents.add(reportedEvent);
    }
    return reportedEvents;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Reported Events",
            style: GoogleFonts.prompt(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          centerTitle: true,
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
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: getReportedEvents(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.red.shade900,
                          strokeWidth: 5,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Lottie.asset(
                          Theme.of(context).brightness == Brightness.dark
                              ? 'assets/loadingdark.json'
                              : 'assets/loading.json',
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                        child: Card(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.purple.shade100
                              : Colors.teal.shade100,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child:
                          // Column(
                          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //  children: [
                          //  Cust_Search_Bar(),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child:
                            // Column(
                            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //     children: [
                            //     Cust_Search_Bar(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                // Show id on left side
                                Text(
                                  snapshot.data![index].id,
                                  style: GoogleFonts.poppins(color: Colors.black),
                                ),

                                // Show username and email in the middle
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        snapshot.data![index].eventName,
                                        style: GoogleFonts.poppins(
                                            fontSize: 20, color: Colors.black)
                                    ),
                                    Text(
                                      snapshot.data![index].eventDate,
                                      style: GoogleFonts.poppins(color: Colors.blue),
                                    ),
                                  ],
                                ),

                                // Show delete button on the right side
                                IconButton(
                                  onPressed: () {
                                    delrecord(snapshot.data![index].id,snapshot.data![index].event_venue);
                                    print("deleted!"+snapshot.data![index].eventName);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),

                            // ],
                            //     ),
                          ),

                          // ],
                          //     ),
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
  Future<void> delrecord(String id, String eventVenue) async {
    var typee;
    // Show confirmation dialog
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this record?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                print(eventVenue);
                Navigator.of(context).pop(false); // Cancel delete
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm delete
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
    if (eventVenue.isNotEmpty) {
      typee = "online";
    } else {
      typee = "offline";
    }
    // If user confirms delete, proceed with deletion
    if (confirmDelete == true) {
      Map<String, String> requestBody = {"id": id,"type": typee};
      print(requestBody);
      String url = "$ip_address/Event_Management/Admin/delete_event.php";
      var res = await http.post(Uri.parse(url), body: requestBody);
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        setState(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ReportedEventsPage()),
          );
        });
        print("success");
      }
    }
  }


}
