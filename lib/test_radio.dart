import 'package:flutter/material.dart';



class radio extends  StatefulWidget {
  @override
  State<radio> createState() => _radioState();
}

class _radioState extends State<radio> {
  String? gender; //no radio button will be selected
  //String gender = "male"; //if you want to set default value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Radio Button in Flutter"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child:
        Column(
          children: [

            Text("What is your gender?", style: TextStyle(
                fontSize: 18
            ),),

            Divider(),

            RadioListTile(
              title: Text("Male"),
              value: "male",
              groupValue: gender,
              onChanged: (value){
                setState(() {
                  gender = value.toString();
                });
              },
            ),

            RadioListTile(
              title: Text("Female"),
              value: "female",
              groupValue: gender,
              onChanged: (value){
                setState(() {
                  gender = value.toString();
                });
              },
            ),

            RadioListTile(
              title: Text("Other"),
              value: "other",
              groupValue: gender,
              onChanged: (value){
                setState(() {
                  gender = value.toString();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}