import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:event_management/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import '../main.dart';
import 'Edit_data.dart';

//Creating a class user to store the data;
class User_model {
  // final String id;
  final String id;
  final String name;
  final String age;

  User_model({
    // required this.id,
    required this.id,
    required this.name,
    required this.age,
  });
}

class Display_Data extends StatefulWidget {
  @override
  _Display_DataState createState() => _Display_DataState();
}

class _Display_DataState extends State<Display_Data> {
//Applying get request.

  Future<List<User_model>> getRequest() async {
    //replace your restFull API here.
    String url = "http://$ip_address/internship_crud/display_data.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<User_model> users = [];
    for (var singleUser in responseData) {
      User_model user = User_model(
        //id:  singleUser["id"].toString(),
        id: singleUser["id"].toString(),
        name: singleUser["name"].toString(),
        age: singleUser["age"].toString(),
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
          centerTitle: true,
          title: Text(
            "Display Data",
          ),
        ),
      //  body: Scaffold(
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
                          Text(
                            "Data Loading Please Wait!",
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) => Column(
                      children: [
                        Card(
                          color: Colors.pink.shade100,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index].eventname,
                                  ),
                                  leading:  GestureDetector(
                                    onTap: (){
                                      setState(() {

                                      });
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>  Edit_data(data_user: snapshot.data[index],)));
                                    },
                                      
                                      child: Icon(Icons.edit,color: Colors.green.shade900,)),
                                 
                                  subtitle: Text(
                                    snapshot.data[index].age,
                                  ),
                                  trailing: GestureDetector(
                                      onTap: (){

                                        setState(() {
                                          delrecord(snapshot.data[index].id);
                                          // Navigator.pushReplacement(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>  Display_Data()));


                                        });

                                        Fluttertoast.showToast(
                                            msg: 'Data Deleted ',
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.blueGrey);



                                      },
                                      child: Icon(Icons.delete,color: Colors.red.shade900,)),

                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
    //  ),
    );
  }

  Future<void> delrecord(String id) async {
    String url =
        "http://$ip_address/internship_crud/delete_data.php";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,
    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      setState(() {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>  Display_Data()));

      });
print("success");
    }
  }
}


