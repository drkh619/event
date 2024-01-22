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
  final String eventDescription;
  final String status;

  ReportedEventModel({
    required this.id,
    required this.eventName,
    required this.eventDescription,
    required this.status,
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
    String url = "https://parietal-insanities.000webhostapp.com/Event_Management/Admin/reported_events.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    List<ReportedEventModel> reportedEvents = [];
    for (var event in responseData) {
      ReportedEventModel reportedEvent = ReportedEventModel(
        id: event["id"].toString(),
        eventName: event["event_name"].toString(),
        eventDescription: event["event_description"].toString(),
        status: event["status"].toString(),
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
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.purple.shade100
                          : Colors.teal.shade100,
                      child: ListTile(
                        title: Text(snapshot.data[index].eventName, style: TextStyle(color: Colors.black, fontSize: 24),),
                        subtitle: Text(snapshot.data[index].eventDescription, style: TextStyle(color: Colors.black54),),
                        trailing: GestureDetector(
                          onTap: () {
                            // Implement action on tapping the reported event
                            // e.g., review and resolve the reported issue
                            // You can add more functionality here
                            Fluttertoast.showToast(
                              msg: 'Reported Event Tapped',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blueGrey,
                            );
                          },
                          child: Icon(
                            Icons.delete_rounded,
                            // color: Theme.of(context).brightness == Brightness.dark
                            //     ? Colors.purple.shade900
                            //     : Colors.teal.shade900,
                            color: Colors.red.shade800,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
