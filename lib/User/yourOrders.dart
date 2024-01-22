import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cupertino_icons/cupertino_icons.dart';
import 'dart:convert';

class YourOrdersPage extends StatefulWidget {
  final String uid; // Assuming uid is needed to fetch user-specific orders

  YourOrdersPage({required this.uid});

  @override
  _YourOrdersPageState createState() => _YourOrdersPageState();
}

class _YourOrdersPageState extends State<YourOrdersPage> {
  Future<List<dynamic>> getYourOrders() async {
    String apiUrl = "https://parietal-insanities.000webhostapp.com/Event_Management/test.php?uid=${widget.uid}";
    final response = await http.get(Uri.parse(apiUrl));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Your Orders"),
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
                return ListView.builder(
                  itemCount: yourOrders.length,
                  itemBuilder: (ctx, index) {
                    String eventName = yourOrders[index]['eventName'] ?? ''; // Use empty string if null
                    String eventPrice = yourOrders[index]['price'] ?? '';
                    String eventType = yourOrders[index]['event_type'] ?? '';
                    String quantity = yourOrders[index]['quantity'] ?? '';

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.purple.shade100
                            : Colors.teal.shade100,
                        child: ListTile(
                          leading: Icon(
                            // CupertinoIcons.ticket_fill,
                            Icons.fiber_manual_record,
                            color: eventType == 'online_event' ? Colors.green : Colors.red,
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
                              Text('x $quantity',style: TextStyle(color: Colors.black)),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                eventPrice == '0' ? 'Free' : formatPrice(eventPrice),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                eventType == 'online_event' ? 'Online Event' : 'Offline Event',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  String formatPrice(String? price) {
    if (price != null && price.isNotEmpty) {
      final priceValue = int.parse(price);
      return '₹$priceValue'; // Assuming the price is already formatted as currency
    } else {
      return 'Free';
    }
  }
}
