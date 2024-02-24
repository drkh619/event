import 'package:event_management/User/User_Home_Page.dart';
import 'package:event_management/User/unPaid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import 'package:http/http.dart' as http;

class BuyNow extends StatefulWidget {
  final String id;
  final String status;
  final String event_name;
  final String event_start_date;
  final String event_image;
  final String event_end_date;
  final String event_venue;
  final String event_price;
  final String event_link;
  final String event_capacity;
  final String event_description;
  final String place;
  final String uid;

  BuyNow({
    required this.id,
    required this.status,
    required this.event_name,
    required this.event_start_date,
    required this.event_end_date,
    required this.event_image,
    required this.event_capacity,
    required this.event_price,
    required this.event_link,
    required this.event_venue,
    required this.event_description,
    required this.place,
    required this.uid,
  });

  @override
  State<BuyNow> createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {

  var get_event_id;
  String? selectedOption;
  bool isEventReported = false; // Track whether the user has reported a problem



  @override
  void initState() {
    get_event_id = widget.id;
    checkReportStatus(widget.id);
    print("UID:"+widget.uid);
    print(get_event_id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event Details",
          style: GoogleFonts.prompt(color: Colors.white),
        ),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
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
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'report') {
                _showReportDialog(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'report',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.flag_outlined),
                        SizedBox(width: 5),
                        Text('Report a problem'),
                      ],
                    ),
                  ),
                ),
              ];
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 2, child: Container(color: Theme
                  .of(context)
                  .brightness == Brightness.dark
                  ? Colors.purple.shade500
                  : Colors.teal.shade500)),
              Expanded(child: Container(color: Theme
                  .of(context)
                  .brightness == Brightness.dark ? Color(0xFF121212) : Colors
                  .white)),
            ],
          ),
          Align(
            alignment: Alignment(0, 0.2),
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.1,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.2,
              child: Card(
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark ?
                Theme
                    .of(context)
                    .cardTheme
                    .color :
                Colors.teal.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 12,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(widget.event_image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child:
                        Text(
                          widget.event_name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.alexandria(
                            color: Theme
                                .of(context)
                                .brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // Text(widget.id),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              getTimeBoxUI(
                                  widget.event_start_date, 'Start Date'),
                              getTimeBoxUI(widget.event_end_date, 'End Date'),
                            ],
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              getTimeBoxUI(widget.event_capacity, 'Seats'),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              widget.event_venue != null &&
                                  widget.event_venue.isNotEmpty
                                  ? Icons.location_on
                                  : Icons.radio_button_checked,
                              color: widget.event_venue != null &&
                                  widget.event_venue.isNotEmpty
                                  ? Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors
                                  .white // Use white color for the location icon in dark mode
                                  : Colors
                                  .black54 // Use your preferred color for the location icon in light mode
                                  : Colors
                                  .green, // Use green color for the radio button checked icon
                            ),

                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.event_venue != null &&
                                        widget.event_venue.isNotEmpty
                                        ? widget.event_venue
                                        : 'Online Event',
                                    // Default message when event_venue is not present
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Theme
                                          .of(context)
                                          .brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  if (widget.event_venue != null &&
                                      widget.event_venue
                                          .isNotEmpty) // Conditionally show parentheses
                                    Row(
                                      children: [
                                        Text(
                                          "(",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w200,
                                            color: Theme
                                                .of(context)
                                                .brightness == Brightness.dark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            widget.place ??
                                                'Location not specified',
                                            // Default message when place is not present
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w200,
                                              color: Theme
                                                  .of(context)
                                                  .brightness == Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Text(
                                          ")",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w200,
                                            color: Theme
                                                .of(context)
                                                .brightness == Brightness.dark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                      // Include other details here
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        // Adjust the padding as needed
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.event_price == '0'
                                ? 'Free'
                                : '₹' + NumberFormat('#,##,###').format(
                                int.parse(widget.event_price)),
                            style: GoogleFonts.alexandria(
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: MarkdownBody(
                          data: widget.event_description,
                          styleSheet: MarkdownStyleSheet(
                            p: TextStyle(
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            h1: TextStyle(
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            h2: TextStyle(
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            h3: TextStyle(
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            em: TextStyle(
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            listBullet: TextStyle(
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            blockquote: TextStyle(
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UnpaidPage(id: widget.id, event_name: widget.event_name, event_image: widget.event_image, event_price: widget.event_price,),
                                ),
                              );
                              // Your button's onPressed logic here


                              widget.event_venue == null ? event_type ='online_event' :
                              widget.event_venue !=  null  && widget.event_venue.isNotEmpty ? event_type = 'offline_event':
                              event_type ='online_event';


                              print("test for event type ${event_type}");

                            },
                            style: ElevatedButton.styleFrom(
                              primary: Theme
                                  .of(context)
                                  .primaryColor,
                              // Choose appropriate colors for dark and light mode
                              onPrimary: Colors.white,
                              // Text color
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Text("Buy Now", style: GoogleFonts.prompt(
                                color: Colors.white, fontSize: 16),),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),

                    ],

                  ),
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.white.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.lightBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
     // Initialize to null

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text('Report a Problem', style: GoogleFonts.poppins(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
              ))),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    title: Text("Advertising/Promotions"),
                    value: "promo",
                    groupValue: selectedOption,
                    onChanged: (value){
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Profanity and Nudity"),
                    value: "nudity",
                    groupValue: selectedOption,
                    onChanged: (value){
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Piracy"),
                    value: "piracy",
                    groupValue: selectedOption,
                    onChanged: (value){
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Scam/Illegal Activity"),
                    value: "scam",
                    groupValue: selectedOption,
                    onChanged: (value){
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Other Reasons"),
                    value: "other",
                    groupValue: selectedOption,
                    onChanged: (value){
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                ],
              );
            }
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: !isEventReported
                  ? () {
                // Check if the user has not reported the event
                submit();



                // Update isEventReported flag
                setState(() {
                  isEventReported = true;
                });

                // Save reporting status to local storage
                saveReportStatus(widget.id);

                // Update isEventReported flag
                setState(() {
                  isEventReported = true;
                });


                // Perform actions based on the selected option
                if (selectedOption != null) {
                  print('Report submitted: $selectedOption');
                  print(userid);
                }



              }: null,
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  //here
  // Check reporting status for the current user and event
  Future<void> checkReportStatus(String eventId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the user ID from local storage
    String? userId = prefs.getString('user_id');

    // Check if the user has reported the event
    setState(() {
      isEventReported = prefs.getBool('reported_${userId}_$eventId') ?? false;
    });
  }

  // Save reporting status for the current user and event
  Future<void> saveReportStatus(String eventId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the user ID from local storage
    String? userId = prefs.getString('user_id');

    // Save reporting status with a combination of user ID and event ID
    prefs.setBool('reported_${userId}_$eventId', true);
  }
  //tohere

  submit() async {
    String reportUrl = widget.event_venue != null && widget.event_venue.isNotEmpty
        ? "$ip_address/Event_Management/report_event.php"
        : "$ip_address/Event_Management/report_event_online.php";

    final response = await http.post(
        Uri.parse(reportUrl),
        body: {
          "id":get_event_id,
          "status": selectedOption,
          "uid": widget.uid,

        });
    if (response.statusCode == 200) {
      print(reportUrl);
      print('Event Reported');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>User_HomePage()));


      final snackBar = await SnackBar(
        content: const Text('Event reported successfully!'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            //Navigator.pop(context);
            // Some code to undo the change.
          },
        ),
      );
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print("not");
      final snackBar = await SnackBar(
        content: const Text('Event updation failed!'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            //Navigator.pop(context);
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    //setState(() {});
  }

}

