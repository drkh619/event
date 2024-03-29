import 'dart:convert';
import 'package:event_management/User/checkout.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

import '../main.dart';


//Creating a class user to store the data;
class organizer_model {
  final String uid;
  final String username;
  final String email;
  var status;


  organizer_model({
    required this.uid,
    required this.username,
    required this.email,
    required this.status,

  });
}

class manage_organiser2 extends StatefulWidget {
  @override
  _manage_organiser2State createState() => _manage_organiser2State();
}

class _manage_organiser2State extends State<manage_organiser2> {

  Future<List<organizer_model>>? _refresh;

  @override
  void initState() {
    super.initState();
    _refresh = getRequest();
  }

  Future<void> _onRefresh() async {
    setState(() {
      _refresh = getRequest();
    });
  }

//Applying get request.

  Future<List<organizer_model>> getRequest() async {
    //replace your restFull API here.
    String url =
        "$ip_address/Event_Management/Admin/union_test.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<organizer_model> users = [];
    for (var singleUser in responseData) {
      organizer_model user = organizer_model(
        //id:  singleUser["id"].toString(),
        username : singleUser["username"].toString(),
        email :singleUser["email"].toString(),
        uid : singleUser["id"].toString(),
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
              child: RefreshIndicator(
                onRefresh: _onRefresh,
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
                                            (snapshot.data![index].username),
                                            style: GoogleFonts.roboto(
                                                fontSize: 20, color: Colors.yellow.shade900)
                                          ),
                                          SizedBox(width: 10,),
                                          GestureDetector(
                                            onTap: () {
                                              delrecord(snapshot.data![index].uid);
                                              print("deleted!"+snapshot.data![index].uid);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          )
                
                                        ],
                                      ):
                
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              (snapshot.data![index].username),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20, color: Colors.black)
                                          ),
                                          SizedBox(width: 10,),
                                          GestureDetector(
                                            onTap: () {
                                              delrecord(snapshot.data![index].uid);
                                              print("deleted!"+snapshot.data![index].uid);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(snapshot.data![index].email,style: GoogleFonts.poppins(color: Colors.blue),),
                
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
            ),

          ],
        ),
      ),
    );
  }
  Future<void> delrecord(String id) async {
    // Show confirmation dialog
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this record?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel delete
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm delete
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );

    // If user confirms delete, proceed with deletion
    if (confirmDelete == true) {
      String url = "$ip_address/Event_Management/delete_data.php";
      var res = await http.post(Uri.parse(url), body: {
        "id": id,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        setState(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => manage_organiser2()),
          );
        });
        print("success");
      }
    }
  }
}
