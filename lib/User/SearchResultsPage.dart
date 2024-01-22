import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../Organizer/display_data_detail_offline.dart';
import '../main.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchText;

  SearchResultsPage({required this.searchText});

  Future<List<dynamic>> getSearchResults() async {
    String url = "http://$ip_address/Event_Management/User/search.php?searchText=$searchText";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
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
                return ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (ctx, index) {
                    String eventName = searchResults[index]['event_name'] ?? '';  // Use empty string if null
                    String eventStartDate = searchResults[index]['event_start_date'] ?? '';
                    String eventEndDate = searchResults[index]['event_end_date'] ?? '';
                    String eventVenue = searchResults[index]['event_venue'] ?? '';
                    String eventPrice = searchResults[index]['event_price'] ?? '';
                    String eventCapacity = searchResults[index]['event_capacity'] ?? '';
                    String eventDescription = searchResults[index]['event_description'] ?? '';
                    String eventImage = searchResults[index]['event_image'] ?? '';
                    String place = searchResults[index]['place'] ?? '';
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              ctx,
                              MaterialPageRoute(
                                builder: (context) => DetailOffline(
                                  event_name: eventName,
                                  event_start_date: eventStartDate,
                                  event_end_date: eventEndDate,
                                  event_image: eventImage,
                                  event_capacity: eventCapacity,
                                  event_price: eventPrice,
                                  event_venue: eventVenue,
                                  event_description: eventDescription,
                                  place: place,
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
                                    leading: Icon(Icons.location_on, color: Colors.black54,),
                                    title: Text('$eventVenue', style: TextStyle(color: Colors.black54),),
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
