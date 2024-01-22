import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

import '../main.dart';


//Creating a class user to store the data;
class organizer_model {
  // final String id;
  final String uid;
  final String event_name;
  final String organiser_name;
  var status;


  organizer_model({
    // required this.id,
    required this.uid,
    required this.event_name,
    required this.organiser_name,
    required this.status,

  });
}

class manage_organiser2 extends StatefulWidget {
  @override
  _manage_organiser2State createState() => _manage_organiser2State();
}

class _manage_organiser2State extends State<manage_organiser2> {
//Applying get request.

  Future<List<organizer_model>> getRequest() async {
    //replace your restFull API here.
    String url =
        "https://parietal-insanities.000webhostapp.com/Event_Management/Admin/union_test.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<organizer_model> users = [];
    for (var singleUser in responseData) {
      organizer_model user = organizer_model(
        //id:  singleUser["id"].toString(),
        uid: singleUser["uid"].toString(),
        event_name: singleUser["event_name"].toString(),
        organiser_name:singleUser["organiser_name"].toString(),
        status: int.parse(singleUser['status']),
      );

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
            "Display Organizer",
            style: GoogleFonts.prompt(fontSize: 22, color: Colors.white),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        body: Column(
          children: [



            Flexible(
              child: FutureBuilder<List>(
                  future: getRequest(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      Fluttertoast.showToast(
                          msg: 'Error',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          webPosition: 1,
                          backgroundColor: Colors.blueGrey);

                    //   return snapshot.hasData ? Display_Data_Items(list: snapshot.data ?? [])  : Center(child: CircularProgressIndicator(),

                    return snapshot.hasData
                        ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                            child: Card(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.purple.shade100
                                  : Colors.teal.shade100,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child:
                              // Column(
                              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //  children: [
                              //  Cust_Search_Bar(),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:
                                // Column(
                                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //     children: [
                                //     Cust_Search_Bar(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    // Text(snapshot.data![index].status,style: TextStyle(color: Colors.black),),



                                    snapshot.data![index].status >= 10 ?

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          (snapshot.data![index].organiser_name),
                                          style: GoogleFonts.roboto(
                                              fontSize: 20, color: Colors.yellow.shade900)
                                        ),
                                        SizedBox(width: 10,),
                                        Icon(Icons.delete,color: Colors.red,),
                                      ],
                                    ):

                                    Text(
                                        (snapshot.data![index].organiser_name),
                                        style: GoogleFonts.roboto(
                                            fontSize: 20, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                                    ),
                                    Text(snapshot.data![index].event_name,style: TextStyle(color: Colors.blue),),

                                  ],
                                  //   ),
                                  //
                                  // ],
                                ),
                                // ],
                              ),

                              // ],
                              //     ),
                            ),
                          );
                        })
                        : Center(child: CircularProgressIndicator());
                  }),
            ),

          ],
        ),
      ),
    );
  }

}
