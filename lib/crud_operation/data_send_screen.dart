import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:event_management/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;



class data_send_screen extends StatefulWidget {
  const data_send_screen({Key? key}) : super(key: key);

  @override
  State<data_send_screen> createState() => _data_send_screenState();
}

class _data_send_screenState extends State<data_send_screen> {

  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late bool status;
  late String message;

  @override
  void initState() {
    namecontroller = TextEditingController();
    agecontroller = TextEditingController();

    status = false;
    message = "";

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("send_data_screen"),
        backgroundColor: Colors.pink,
        centerTitle: true,

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key:_formkey,
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: namecontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Enter name",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                SizedBox(height:20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller:agecontroller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Enter age",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Submit();
                        namecontroller.clear();
                        agecontroller.clear();


                      },
                      child: Text("SUBMIT"),
                    ),
                    Text(status ? message : message,style: TextStyle(color: Colors.red.shade900),),







                  ],
                )

              ],
            ),
          ),
        ),

      ),

    );
  }
  Future Submit() async {
    var APIURL =
        "$ip_address/internship_crud/add_data.php";


    //json maping user entered details
    Map maped_data = {
      'name': namecontroller.text,
      'age': agecontroller.text,
    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(APIURL), body: maped_data);

    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    var responseMessage = data["message"];
    var responseError = data["error"];

    // print("DATA: ${data}");
    print(data);

    if (responseError) {
      setState(() {
        status = false;
        message = responseMessage;
      });
    } else {
      namecontroller.clear();
      agecontroller.clear();

      setState(() {
        status = true;
        message = responseMessage;
      });
      Fluttertoast.showToast(
          msg: "send successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey);
    }
  }

}
