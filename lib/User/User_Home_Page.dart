import 'dart:convert';
import 'package:event_management/User/User_drawer.dart';
import 'package:event_management/User/buynow.dart';
import 'package:event_management/User/parallax_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'SearchResultsPage.dart';
import 'User_Login_Page.dart';

class User_HomePage extends StatefulWidget {
  const User_HomePage({Key? key}) : super(key: key);


  @override
  _User_HomePageState createState() => _User_HomePageState();
}

class _User_HomePageState extends State<User_HomePage> {

  Future<List<dynamic>>? _refresh;

  @override
  void initState() {
    super.initState();
    _refresh = getAllEvents();
  }

  Future<void> _onRefresh() async {
    setState(() {
      _refresh = getAllEvents();
    });
  }

  TextEditingController _searchController = TextEditingController();
  static const images = <String>[
    'assets/delhi.jpg',
    'assets/hyderabad.jpg',
    'assets/chennai.jpg',
    'assets/bangalore.jpg',
    'assets/kerala.jpg',
    'assets/ahmedabad.jpg',
    'assets/mumbai.jpg',
    'assets/goa.jpg',
    'assets/jaipur.jpg',
    'assets/pune.jpg',
    'assets/kolkata.jpg',
  ];
  static const customTexts = [
    'Delhi',
    'Hyderabad',
    'Chennai',
    'Bangalore',
    'Kerala',
    'Ahmedabad',
    'Mumbai',
    'Goa',
    'Jaipur',
    'Pune',
    'Kolkata',
  ];
  static const List<String> categoryWords = [
    "art",
    "fitness",
    "business",
    "IT",
    "workshops",
    "enjoyment",
  ];
  TextEditingController _tokenController = TextEditingController();
  bool isTokenValid = true; // Variable to track if the entered token is valid

  Future<List<dynamic>> getAllEvents() async {
    String eventsUrl = "$ip_address/Event_Management/User/allevent.php";
    String ordersUrl = "$ip_address/Event_Management/User/orders.php";

    // Make parallel HTTP requests to get events and orders
    final eventsResponse = await http.get(Uri.parse(eventsUrl));
    final ordersResponse = await http.get(Uri.parse(ordersUrl));

    if (eventsResponse.statusCode == 200 && ordersResponse.statusCode == 200) {
      // Decode events and orders data
      List<dynamic> allEvents = json.decode(eventsResponse.body);
      List<dynamic> orders = json.decode(ordersResponse.body);

      // Get today's date
      DateTime today = DateTime.now();

      // Filter events based on event_start_date
      List<dynamic> filteredEvents = allEvents.where((event) {
        // Parse the date string with the correct format
        DateTime eventStartDate = DateFormat('dd-MM-yyyy').parse(event['event_start_date'] ?? '', true);

        return eventStartDate.isAfter(today); // Change to isBefore if you want events that have already started
      }).toList();

      // Check if the quantity for each event equals the event_capacity
      List<dynamic> validEvents = filteredEvents.where((event) {
        // Find orders for the current event
        List<dynamic> eventOrders = orders.where((order) => order['eventId'] == event['id']).toList();
        int quantity = eventOrders.fold(0, (sum, order) => sum + int.parse(order['quantity']));

        // Return true if the quantity is less than the event_capacity
        return quantity < int.parse(event['event_capacity']);
      }).toList();

      return validEvents;
    } else {
      throw Exception('Failed to load events or orders');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Organizer Home Page"),
        // title: Text(userid),
        centerTitle: true,
        title: Text("Homepage", style: TextStyle(color: Colors.white),),
        // userid
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () async {
              bool confirmed = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Logout'),
                    content: Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false); // Return false when Cancel is pressed
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Perform logout action here
                          final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
                          sharedpreferences.remove('user_id');
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => User_Login_Page(),
                            ),
                          );
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
              // Use the value of confirmed if needed
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      drawer: Drawer(
        child: User_Drawer(),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          // child: ExampleParallax(),
          child: Center(
            child: Column(
              children: [

                // TextButton(onPressed: (){
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => radio()));
                // }, child: Text("radio")),

                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                            ),
                            textInputAction: TextInputAction.search, // Set the text input action to search
                            onSubmitted: (value) {
                              onSearchButtonClicked();
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 200,
                  child: ParallaxSwiper(
                    // List of image URLs to display
                    images: images,
                    // Fraction of the viewport for each image
                    viewPortFraction: 0.85,
                    // Disable the background zoom effect
                    backgroundZoomEnabled: false,
                    // Disable the foreground fade effect
                    foregroundFadeEnabled: false,
                    customTexts: customTexts,
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              height: 650,
                              child: Column(
                                children: [
                                  // Center bar or scroll indicator
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 5,
                                      width: 100,
                                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(50)),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              'Private Event',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).brightness == Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          // TextField for entering the private token
                                          Padding(
                                            padding: const EdgeInsets.all(30.0),
                                            child: TextField(
                                              controller: _tokenController,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(4),
                                              ],
                                              decoration: InputDecoration(
                                                labelText: 'Enter Token',
                                                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                                                errorText: _tokenController.text.length < 4
                                              ? 'Please enter at least 4 characters'
                                                : isTokenValid
                                                ? null
                                                : 'Invalid token, please try again',
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 50),
                                          // ElevatedButton to submit the token
                                          ElevatedButton(
                                            onPressed: _tokenController.text.length == 4 ? () async {
                                              // Call the PHP API to check the token
                                              List<dynamic> event = await checkToken(_tokenController.text);

                                              // If the token is valid, navigate to buynow.dart
                                              if (event.isNotEmpty) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => BuyNow(
                                                      id: event[0]['id'] ?? '',
                                                      event_name: event[0]['event_name'] ?? '',
                                                      event_start_date: event[0]['event_start_date'] ?? '',
                                                      event_end_date: event[0]['event_end_date'] ?? '',
                                                      event_image: event[0]['event_image'] ?? '',
                                                      event_capacity: event[0]['event_capacity'] ?? '',
                                                      event_price: event[0]['event_price'] ?? '',
                                                      event_link: event[0]['event_link'] ?? '',
                                                      event_venue: event[0]['event_venue'] ?? '',
                                                      event_description: event[0]['event_description'] ?? '',
                                                      place: event[0]['place'] ?? '',
                                                      status: event[0]['status'] ?? '',
                                                      uid: event[0]['uid'] ?? '',
                                                      // Pass other item details as needed
                                                    ),
                                                  ),
                                                );
                                              }
                                              // Update the state based on the API response
                                              setState(() {
                                                isTokenValid = event.isNotEmpty;
                                              });
                                            } : null,
                                            style: ElevatedButton.styleFrom(
                                              primary: Theme.of(context).primaryColor,
                                              onPrimary: Colors.white,
                                              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text('Submit', style: TextStyle(fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          elevation: 50,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: Theme.of(context).brightness == Brightness.dark ?
                        Colors.deepPurple.shade200 :
                        Colors.teal.shade300,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add_circle),
                          SizedBox(width: 10),
                          Text("Private Event"),
                        ],
                      ),
                    ),
                  ),
                ),


                FutureBuilder(
                  future: getAllEvents(),
                  builder: (BuildContext ctx, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        List<dynamic> allEvents = snapshot.data!;
                        return Column(
                          children: [
                            for (var event in allEvents) ...[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        ctx,
                                        MaterialPageRoute(
                                          builder: (context) => BuyNow(
                                            id: event['id'] ?? '',
                                      event_name: event['event_name'] ?? '',
                                      event_start_date: event['event_start_date'] ?? '',
                                      event_end_date: event['event_end_date'] ?? '',
                                      event_image: event['event_image'] ?? '',
                                      event_capacity: event['event_capacity'] ?? '',
                                      event_price: event['event_price'] ?? '',
                                      event_link: event['event_link'] ?? '',
                                      event_venue: event['event_venue'] ?? '',
                                      event_description: event['event_description'] ?? '',
                                      place: event['place'] ?? '',
                                      status: event['status'] ?? '',
                                      uid: event['uid'] ?? '',
                                      // Pass other item details as needed
                                          ),
                                        ),
                                    );
                                  },
                                  child: Container(
                                    child: Card(
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? Colors.purple.shade100
                                          : Colors.teal.shade100,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              event['event_image'] ?? '',
                                              height: 100,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 0.0),
                                            child: ListTile(
                                              title: Text(
                                                event['event_name'] ?? '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
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
                                                event['event_venue'] != null && event['event_venue'].isNotEmpty
                                                    ? Icons.location_on
                                                    : Icons.radio_button_checked,
                                                color: event['event_venue'] != null && event['event_venue'].isNotEmpty
                                                    ? Colors.black54  // Use your preferred color for the location icon
                                                    : Colors.green,    // Use green color for the radio button checked icon
                                              ),
                                              title: Text(
                                                event['event_venue'] ?? 'Online Event',
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
                                              subtitle: Text('${event['event_start_date'] ?? ''} to ${event['event_end_date'] ?? ''}'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: ListTile(
                                              title: Text(
                                                '${event['event_price'] == '0' ? 'Free' : formatPrice(event['event_price'] ?? '')}',
                                                style: GoogleFonts.nunitoSans(
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
                                ),
                              ),
                              // SizedBox(height: 20),
                            ],
                          ],
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  //here
  // Function to check the token against the PHP API
  Future<List<dynamic>> checkToken(String token) async {
    String apiEndpoint = '$ip_address/Event_Management/User/checkToken.php?token=$token';
    final response = await http.get(Uri.parse(apiEndpoint));

    if (response.statusCode == 200) {
      // If the token is valid, return the list of events
      _tokenController.clear();
      return json.decode(response.body);
    } else {
      // If the token is not valid, return an empty list or handle it accordingly
      return [];
    }
  }

  //to here

  void onSearchButtonClicked() {
    // Perform the search when the search button is clicked
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsPage(
          searchText: _searchController.text,

        ),
      ),
    );
  }
}
Future<bool> checkToken(String token) async {
  try {
    String apiEndpoint = '$ip_address/Event_Management/User/privateevent.php?token=$token';
    final response = await http.get(Uri.parse(apiEndpoint));

    if (response.statusCode == 200) {
      // Check the response body or perform any validation logic
      // Return true if the token is considered valid
      return true;
    } else {
      // Return false if the token is not valid
      return false;
    }
  } catch (error) {
    // Handle any exceptions that might occur during the HTTP request
    print('Error checking token: $error');
    return false;
  }
}

