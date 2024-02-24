import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';

import '../Organizer/display_data_detail_offline.dart';
import '../main.dart';
import 'buynow.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchText;

  SearchResultsPage({required this.searchText});

  Future<List<dynamic>> getSearchResults() async {
    // Define the URL for fetching search results
    String searchUrl = "$ip_address/Event_Management/User/search.php?searchText=$searchText";

    // Make an HTTP request to get search results
    final searchResponse = await http.get(Uri.parse(searchUrl));

    // Check if the HTTP request is successful
    if (searchResponse.statusCode == 200) {
      // Decode the response body containing search results
      List<dynamic> searchResults = json.decode(searchResponse.body);

      // Filter search results based on event capacity and orders
      List<dynamic> filteredResults = await filterSearchResults(searchResults);

      return filteredResults;
    } else {
      // If the request fails, throw an exception
      throw Exception('Failed to load search results');
    }
  }

  Future<List<dynamic>> filterSearchResults(List<dynamic> searchResults) async {
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

      // Filter search results based on event capacity and orders
      List<dynamic> filteredResults = searchResults.where((event) {
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

      return filteredResults;
    } else {
      // If the request fails, throw an exception
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results", style: GoogleFonts.prompt(color: Colors.white)),
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
          future: getSearchResults(),
          builder: (BuildContext ctx, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<dynamic> searchResults = snapshot.data!;
                if (searchResults.isEmpty) {
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
                    itemCount: searchResults.length,
                    itemBuilder: (ctx, index) {
                      String id = searchResults[index]['id'] ?? '';
                      String eventName = searchResults[index]['event_name'] ?? '';  // Use empty string if null
                      String eventStartDate = searchResults[index]['event_start_date'] ?? '';
                      String eventEndDate = searchResults[index]['event_end_date'] ?? '';
                      String eventVenue = searchResults[index]['event_venue'] ?? '';
                      String eventPrice = searchResults[index]['event_price'] ?? '';
                      String eventCapacity = searchResults[index]['event_capacity'] ?? '';
                      String eventDescription = searchResults[index]['event_description'] ?? '';
                      String eventImage = searchResults[index]['event_image'] ?? '';
                      String place = searchResults[index]['place'] ?? '';
                      String status = searchResults[index]['status'] ?? '';
                      String event_link = searchResults[index]['event_link'] ?? '';
                      String uid = searchResults[index]['uid'] ?? '';
                      String test = eventVenue!= null && eventVenue.isNotEmpty ? '$eventVenue' : 'Online Event';
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
                                    event_link: event_link,
                                    uid: uid,
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
                                        eventVenue != null && eventVenue.isNotEmpty
                                            ? Icons.location_on
                                            : Icons.radio_button_checked,
                                        color: eventVenue != null && eventVenue.isNotEmpty
                                            ? Colors.black54  // Use your preferred color for the location icon
                                            : Colors.green,    // Use green color for the radio button checked icon
                                      ),
                                      title: Text(
                                        test,
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      textColor: Colors.black,
                                      //subtitle: Text('${event['event_start_date'] ?? ''} to ${event['event_end_date'] ?? ''}'),
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
                                      title: Text(eventPrice == '0' ? 'Free' : formatPrice('$eventPrice'),
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
                          SizedBox(height: 30,),
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
