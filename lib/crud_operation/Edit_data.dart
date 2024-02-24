import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:event_management/main.dart';
import 'package:http/http.dart' as http;

import 'Display_Data.dart';


class Edit_data extends StatefulWidget {
  final User_model data_user;

  Edit_data({required this.data_user});

  @override
  _Edit_dataState createState() => _Edit_dataState();
}

class _Edit_dataState extends State<Edit_data> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  submit() async {
    final response = await http.post(
        Uri.parse("$ip_address/internship_crud/update_data.php"),
        body: {
          "id": widget.data_user.id.toString(),
          "name": name.text,
          "age": age.text,
        });
    if (response.statusCode == 200) {
      print('Image Uploded');
      name.clear();
      age.clear();

      final snackBar = await SnackBar(
        content: const Text('Event updated successfully!'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            //Navigator.pop(context);
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print("not");
      final snackBar = await SnackBar(
        content: const Text('Event updation failed!'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            //Navigator.pop(context);
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {});
  }

  @override
  void initState() {
    name = TextEditingController(text: widget.data_user.name);
    age = TextEditingController(text: widget.data_user.age);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Edit Event",
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded, color: Colors.pink.shade300,
            size: 35, // add custom icons also
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        labelText: "Enter event name",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: TextFormField(
                      controller: age,
                      decoration: InputDecoration(
                        labelText: "Pick event date",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                        ),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.pink.shade200,
                      padding: EdgeInsets.only(
                          left: 100, right: 100, top: 20, bottom: 20),
                    ),
                    onPressed: () {
                      submit();
                      name.clear();
                      age.clear();
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
