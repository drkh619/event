import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../main.dart';

class YourOrdersPage extends StatefulWidget {
  final String uid; // Assuming uid is needed to fetch user-specific orders

  YourOrdersPage({required this.uid});

  @override
  _YourOrdersPageState createState() => _YourOrdersPageState();
}

class _YourOrdersPageState extends State<YourOrdersPage> {
  Future<List<dynamic>> getYourOrders() async {
    String apiUrl = "$ip_address/Event_Management/test.php?uid=${widget.uid}";
    final response = await http.get(Uri.parse(apiUrl));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Your Orders",style: GoogleFonts.poppins(color: Colors.white)),
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
          future: getYourOrders(),
          builder: (BuildContext ctx, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<dynamic> yourOrders = snapshot.data ?? [];
                if (yourOrders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/sorry.json',
                          // Replace with your Lottie animation asset
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: yourOrders.length,
                    itemBuilder: (ctx, index) {
                      String paymentId = yourOrders[index]['id'] ?? '';
                      String eventName = yourOrders[index]['eventName'] ??
                          ''; // Use empty string if null
                      String eventPrice = yourOrders[index]['price'] ?? '';
                      String eventType = yourOrders[index]['event_type'] ?? '';
                      String quantity = yourOrders[index]['quantity'] ?? '';
                      // eid = yourOrders[index]['eventId'] ?? '';

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            _showEventDetails(
                                eventName,
                                yourOrders[index]['eventId'],
                                yourOrders[index]['event_type'],
                                paymentId);
                          },
                          child: Card(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.purple.shade100
                                    : Colors.teal.shade100,
                            child: ListTile(
                              leading: Icon(
                                // CupertinoIcons.ticket_fill,
                                Icons.fiber_manual_record,
                                color: eventType == 'online_event'
                                    ? Colors.green
                                    : Colors.red,
                                size: 16.0,
                              ),
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  eventName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    CupertinoIcons.ticket_fill,
                                    color: Colors.black38,
                                    size: 20.0,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text('x $quantity',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eventPrice == '0'
                                        ? 'Free'
                                        : formatPrice(eventPrice),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(
                                    eventType == 'online_event'
                                        ? 'Online Event'
                                        : 'Offline Event',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            }
          },
        ),
      ),
    );
  }

  String formatPrice(String? price) {
    if (price != null && price.isNotEmpty) {
      final priceValue = int.parse(price);
      return '₹$priceValue'; // Assuming the price is already formatted as currency
    } else {
      return 'Free';
    }
  }

  Future<void> _showEventDetails(String eventName, String eventId,
      String eventType, String paymentId) async {
    String apiUrl = "$ip_address/Event_Management/user/link.php?id=$eventId";
    final response = await http.get(Uri.parse(apiUrl));
    List<dynamic> eventData = json.decode(response.body);

    String link = eventData.isNotEmpty ? eventData[0]['event_link'] : '';
    String dateString = eventData.isNotEmpty ? eventData[0]['event_end_date'] : '';

    // DateTime eventEndDate = DateFormat('dd-MM-yyyy').parse(dateString);
    // DateTime today = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Ticket', style: GoogleFonts.poppins(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: QrImageView(
                  data: paymentId,
                  version: QrVersions.auto,
                  size: 150.0,
                ),
              ),
              SizedBox(height: 8),
              Text('Event Name: $eventName',
                  style: GoogleFonts.poppins(fontSize: 18,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
              Text('Event Type: $eventType',
                  style: GoogleFonts.poppins(fontSize: 18,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
              Text('Event ID: $eventId',
                  style: GoogleFonts.poppins(fontSize: 18,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
              if (eventType == 'online_event' && link.isNotEmpty) ...[
                SizedBox(height: 8),
                Text('Event Link: $link',
                    style: GoogleFonts.poppins(fontSize: 18,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
              ],
              SizedBox(height: 16),
            ],
          ),
          actions: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (eventType == 'online_event' && link.isNotEmpty) ...[
                    TextButton(
                      onPressed: () async {
                        if (!await launch(link,
                            forceWebView: false, enableJavaScript: true)) {
                          throw 'Could not launch $link';
                        }
                      },
                      child: Text('Open Link'),
                    ),
                  ],
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close', style: GoogleFonts.poppins()),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
