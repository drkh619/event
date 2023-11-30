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

import 'Update_data_offline.dart';
import 'display_data_detail_offline.dart';


//Creating a class user to store the data;
class offline_data_model {
  final String id;
  final String event_name;
  final String event_start_date;
  final String event_end_date;
  final String event_venue;
  final String event_price;
  final String event_capacity;
  final String event_description;
  final String event_image;
  final String place;

  offline_data_model({
    required this.id,
    required this.event_name,
    required this.event_start_date,
    required this.event_end_date,
    required this.event_venue,
    required this.event_price,
    required this.event_capacity,
    required this.event_description,
    required this.event_image,
    required this.place,
  });
}

class Display_Data_Offline extends StatefulWidget {
  @override
  _Display_Data_OfflineState createState() => _Display_Data_OfflineState();
}

class _Display_Data_OfflineState extends State<Display_Data_Offline> {
//Applying get request.

  Future<List<offline_data_model>> getRequest() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var ui = await sharedprefs.getString('organizer_uid');
    //replace your restFull API here.
    String url = "http://$ip_address/Event_Management/display_data_offline.php?uid="+ui!;

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<offline_data_model> users = [];
    for (var singleUser in responseData) {
      offline_data_model user = offline_data_model(
        id:  singleUser["id"].toString(),
        event_name: singleUser["event_name"].toString(),
        event_start_date: singleUser["event_start_date"].toString(),
        event_end_date: singleUser["event_end_date"].toString(),
        event_venue: singleUser["event_venue"].toString(),
        event_price: singleUser["event_price"].toString(),
        event_capacity: singleUser["event_capacity"].toString(),
        event_description: singleUser["event_description"].toString(),
        event_image: singleUser["event_image"].toString(),
        place: singleUser["place"].toString(),
      );

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Offline Events",
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
            future: getRequest(),
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
                        Lottie.asset(Theme.of(context).brightness == Brightness.dark ? 'assets/loadingdark.json' : 'assets/loading.json',),
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) {
                    DateTime eventDate = DateFormat('dd-MM-yyyy')
                        .parse(snapshot.data[index].event_start_date);
                    int daysDifference =
                        DateTime.now().difference(eventDate).inDays;

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              ctx,
                              MaterialPageRoute(
                                builder: (context) => DetailOffline(
                                  event_name: snapshot.data[index].event_name,
                                  event_start_date: snapshot.data[index].event_start_date,
                                  event_end_date: snapshot.data[index].event_end_date,
                                  event_image: snapshot.data[index].event_image,
                                  event_capacity: snapshot.data[index].event_capacity,
                                  event_price: snapshot.data[index].event_price,
                                  event_venue: snapshot.data[index].event_venue,
                                  event_description: snapshot.data[index].event_description,
                                    place: snapshot.data[index].place,
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
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    title: Text(snapshot.data[index].event_name),
                                    textColor: Colors.black,
                                    leading: GestureDetector(
                                      onTap: () {
                                        setState(() {});
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Update_data_offline(
                                              data_user: snapshot.data[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Theme.of(context).brightness == Brightness.dark
                                            ? Colors.purple.shade900
                                            : Colors.teal.shade900,
                                      ),
                                    ),
                                    subtitle: Text(snapshot.data[index].event_start_date),
                                    trailing: daysDifference >= -2
                                        ? IgnorePointer(
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context).brightness == Brightness.dark
                                            ? Colors.grey
                                            : Colors.grey,
                                      ),
                                    )
                                        : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          delrecord(snapshot.data[index].id);
                                        });

                                        Fluttertoast.showToast(
                                          msg: 'Data Deleted',
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.blueGrey,
                                        );
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context).brightness == Brightness.dark
                                            ? Colors.purple.shade900
                                            : Colors.teal.shade900,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                      ],
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

  Future<void> delrecord(String id) async {
    String url =
        "http://$ip_address/Event_Management/Organise/delete_data_offline.php";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,
    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      setState(() {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>  Display_Data_Offline()));

      });
print("success");
    }
  }
}


