import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../main.dart';


//Creating a class user to store the data;
class userManage_model {
  final String id;
  final String username;
  final String email;


  userManage_model({
    required this.id,
    required this.username,
    required this.email,
  });
}

class manage_users extends StatefulWidget {
  @override
  _manage_usersState createState() => _manage_usersState();
}

class _manage_usersState extends State<manage_users> {

  Future<List<userManage_model>>? _refresh;

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

  Future<List<userManage_model>> getRequest() async {
    //replace your restFull API here.
    String url =
        "$ip_address/Event_Management/Admin/users.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<userManage_model> users = [];
    for (var singleUser in responseData) {
      userManage_model user = userManage_model(
        id: singleUser["id"].toString(),
        username: singleUser["username"].toString(),
        email: singleUser["email"].toString(),
      );


      //Adding user to the list.
      users.add(user);
      print(users);
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
            "Display Users",
            style: GoogleFonts.poppins(fontSize: 22, color: Colors.white),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      // Show id on left side
                                      Text(
                                        snapshot.data![index].id,
                                        style: GoogleFonts.poppins(color: Colors.black),
                                      ),

                                      // Show username and email in the middle
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              snapshot.data![index].username,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20, color: Colors.black)
                                          ),
                                          Text(
                                            snapshot.data![index].email,
                                            style: GoogleFonts.poppins(color: Colors.blue),
                                          ),
                                        ],
                                      ),

                                      // Show delete button on the right side
                                      IconButton(
                                        onPressed: () {
                                          delrecord(snapshot.data![index].id);
                                          print("deleted!"+snapshot.data![index].id);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // ],
                                  //     ),
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
      String url = "$ip_address/Event_Management/Admin/delete_user.php";
      var res = await http.post(Uri.parse(url), body: {
        "id": id,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        setState(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => manage_users()),
          );
        });
        print("success");
      }
    }
  }
}
