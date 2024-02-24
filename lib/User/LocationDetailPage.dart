import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';

import '../Organizer/display_data_detail_offline.dart';
import '../main.dart';
import 'buynow.dart';

class LocationDetailsPage extends StatelessWidget {
  final String locationName;

  LocationDetailsPage({required this.locationName});

  Future<List<dynamic>> getLocationData() async {
    // Define the URL for fetching location data
    String locationUrl = "$ip_address/Event_Management/User/locationdata.php?locationName=$locationName";

    // Make an HTTP request to get location data
    final locationResponse = await http.get(Uri.parse(locationUrl));

    // Check if the HTTP request is successful
    if (locationResponse.statusCode == 200) {
      // Decode the response body containing location data
      List<dynamic> locationData = json.decode(locationResponse.body);

      // Filter location data based on event capacity and orders
      List<dynamic> filteredData = await filterLocationData(locationData);

      return filteredData;
    } else {
      // If the request fails, throw an exception
      throw Exception('Failed to load location data');
    }
  }

  Future<List<dynamic>> filterLocationData(List<dynamic> locationData) async {
    // Define the URL for fetching orders
    String ordersUrl = "$ip_address/Event_Management/User/orders.php";

    // Make an HTTP request to get orders
    final ordersResponse = await http.get(Uri.parse(ordersUrl));

    // Check if the HTTP request is successful
    if (ordersResponse.statusCode == 200) {
      // Decode the response body containing orders
      List<dynamic> orders = json.decode(ordersResponse.body);

      // Get today's date
      DateTime today = DateTime.now();

      // Filter location data based on event capacity and orders
      List<dynamic> filteredData = locationData.where((event) {
        // Parse the event start date string with the correct format
        DateTime eventStartDate = DateFormat('dd-MM-yyyy').parse(event['event_start_date'] ?? '', true);

        // Filter events based on event_start_date
        if (eventStartDate.isAfter(today)) {
          // Find orders for the current event
          List<dynamic> eventOrders = orders.where((order) => order['eventId'] == event['id']).toList();
          int quantity = eventOrders.fold(0, (sum, order) => sum + int.parse(order['quantity']));

          // Return true if the quantity is less than the event_capacity
          return quantity < int.parse(event['event_capacity']);
        } else {
          return false;
        }
      }).toList();

      return filteredData;
    } else {
      // If the request fails, throw an exception
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(locationName, style: GoogleFonts.prompt(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
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
          future: getLocationData(),
          builder: (BuildContext ctx, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<dynamic> locationData = snapshot.data!;
                if (locationData.isEmpty) {
                  // If search results are empty, display Lottie animation
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Lottie.asset(
                          'assets/sorry.json', // Replace with your Lottie animation asset
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'No results found',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: locationData.length,
                    itemBuilder: (ctx, index) {
                      String id = locationData[index]['id'];
                      String eventName = locationData[index]['event_name'];
                      String eventStartDate = locationData[index]['event_start_date'];
                      String eventEndDate = locationData[index]['event_end_date'];
                      String eventVenue = locationData[index]['event_venue'];
                      String eventPrice = locationData[index]['event_price'];
                      String eventCapacity = locationData[index]['event_capacity'];
                      String eventDescription = locationData[index]['event_description'];
                      String eventImage = locationData[index]['event_image'];
                      String place = locationData[index]['place'];
                      String status = locationData[index]['status'];
                      String uid = locationData[index]['uid'] ?? '';

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                ctx,
                                MaterialPageRoute(
                                  builder: (context) => BuyNow(
                                    event_name: eventName,
                                    event_start_date: eventStartDate,
                                    event_end_date: eventEndDate,
                                    event_image: eventImage,
                                    event_capacity: eventCapacity,
                                    event_price: eventPrice,
                                    event_venue: eventVenue,
                                    event_description: eventDescription,
                                    place: place,
                                    id: id,
                                    status: status,
                                    event_link: '',
                                    uid: uid,
                                    // Pass other item details as needed
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.purple.shade100
                                  : Colors.teal.shade100,
                              child: Column(
                                children: [
                                  // Image banner
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      eventImage,
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: ListTile(
                                      title: Text(
                                        eventName,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.alexandria(
                                          color: Colors.black,
                                          fontSize: 26.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.location_on,
                                        color: Colors.black54,
                                      ),
                                      title: Text(
                                        eventVenue,
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      textColor: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: ListTile(
                                      title: Text('Date'),
                                      textColor: Colors.black,
                                      subtitle: Text('$eventStartDate to $eventEndDate'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: ListTile(
                                      title: Text(
                                        eventPrice == '0' ? 'Free' : formatPrice(eventPrice),
                                        style: GoogleFonts.alexandria(
                                          color: Colors.black,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      textColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
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
}

String formatPrice(String? price) {
  if (price != null && price.isNotEmpty) {
    final priceValue = int.parse(price);
    final numberFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    final formattedPrice = numberFormat.format(priceValue);

    // Remove .00 if present
    return formattedPrice.endsWith('.00') ? formattedPrice.substring(0, formattedPrice.length - 3) : formattedPrice;
  } else {
    return 'Free';
  }
}
