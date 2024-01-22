import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class DetailOnline extends StatefulWidget {
  final String event_name;
  final String event_start_date;
  final String event_image;
  final String event_end_date;
  final String event_link;
  final String event_price;
  final String event_capacity;
  final String event_description;

  DetailOnline({
    required this.event_name,
    required this.event_start_date,
    required this.event_end_date,
    required this.event_image,
    required this.event_capacity,
    required this.event_price,
    required this.event_link,
    required this.event_description,
  });

  @override
  State<DetailOnline> createState() => _DetailOnlineState();
}

class _DetailOnlineState extends State<DetailOnline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event Details",
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
      body: Stack(
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
                color: Theme.of(context).brightness == Brightness.dark ?
                Theme.of(context).cardTheme.color :
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
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600,
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
                              getTimeBoxUI(widget.event_start_date, 'Start Date'),
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
                      // Include other details here
                      Padding(
                        padding: EdgeInsets.only(left: 16.0), // Adjust the padding as needed
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '₹' + NumberFormat('#,##,000').format(int.parse(widget.event_price)),
                            style: GoogleFonts.alexandria(
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: MarkdownBody(data: widget.event_description),
                      ),
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
}