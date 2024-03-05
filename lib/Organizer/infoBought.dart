import 'dart:convert';

import 'package:event_management/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> _notifications = [];
  String? _selectedEventName;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController qrController;
  late String qrText;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  @override
  void dispose() {
    qrController.dispose();
    super.dispose();
  }

  Future<void> fetchNotifications() async {
    final String apiUrl = '$ip_address/Event_Management/Organise/bought.php';
    final String orgId = '$userid';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {'orgId': orgId},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      setState(() {
        _notifications.clear();
        _notifications.addAll(data.map((item) => {
          'id': item['id'],
          'eventName': item['eventName'],
          'purchaseDate': item['purchase_date'],
        }));
      });
    } else {
      print('Failed to fetch notifications. Error: ${response.statusCode}');
    }
  }

  List<Map<String, dynamic>> getFilteredNotifications() {
    if (_selectedEventName == null || _selectedEventName!.isEmpty) {
      return _notifications;
    } else {
      return _notifications
          .where((notification) =>
      notification['eventName'] == _selectedEventName)
          .toList();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrController = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code!;
      });
      if (_notifications.any((notification) => notification['id'] == qrText)) {
        qrController.pauseCamera(); // Pause the camera
        Navigator.pop(context); // Pop back to the previous page
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success',style: GoogleFonts.poppins(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),),
            content: Text('Ticket Found!',style: GoogleFonts.poppins(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the AlertDialog
                },
                child: Text('OK',style: GoogleFonts.poppins(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),),
              ),
            ],
          ),
        );
      }
      else {
        qrController.pauseCamera(); // Pause the camera
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error',style: GoogleFonts.poppins(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),),
            content: Text('Invalid ticket',style: GoogleFonts.poppins(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredNotifications = getFilteredNotifications();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Theme.of(context).brightness == Brightness.dark ?
                        Colors.deepPurple.shade200 :
                        Colors.teal.shade300,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.qr_code_scanner_outlined),
                          Text('Scan QR Code'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedEventName,
                  onChanged: (value) {
                    setState(() {
                      if (value == 'Show All') {
                        _selectedEventName = null;
                      } else {
                        _selectedEventName = value;
                      }
                    });
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: 'Show All',
                      child: Text('Show All',style: GoogleFonts.poppins(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),),
                    ),
                    ..._notifications
                        .map((notification) =>
                    notification['eventName'] as String)
                        .toSet()
                        .map((eventName) => DropdownMenuItem<String>(
                      value: eventName,
                      child: Text(eventName,style: GoogleFonts.poppins(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,),),
                    ))
                        .toList()
                  ],
                  decoration: InputDecoration(
                    labelText: 'Select Event Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          if (filteredNotifications.isEmpty)
            Expanded(
              child: Center(
                child: Text('No notifications available'),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: filteredNotifications.length,
                itemBuilder: (context, index) {
                  final notification = filteredNotifications[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 22.0, left: 22.0),
                    child: Card(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.purple.shade100
                          : Colors.teal.shade100,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Text(
                                'ID: ${notification['id']}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              title: Text(notification['eventName'],
                                  style: GoogleFonts.poppins(
                                      fontSize: 18, color: Colors.black87)),
                              subtitle: Text(
                                  'Purchase Date: ${notification['purchaseDate']}',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
