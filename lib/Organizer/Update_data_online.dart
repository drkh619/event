import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import 'Display_Data_Online.dart';

class Edit_Data_with_image extends StatefulWidget {
  final online_data_model data_user;

  Edit_Data_with_image({required this.data_user});

  @override
  _Edit_Data_with_imageState createState() => _Edit_Data_with_imageState();
}

class _Edit_Data_with_imageState extends State<Edit_Data_with_image> {
  var _image;
  final picker = ImagePicker();

  // Add a variable to store the selected date.
  DateTime selectedEndDate = DateTime.now();

  // Function to open the date picker.
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
        eventEndDate.text = "${selectedEndDate.toLocal()}".split(' ')[0];
      });
    }
  }

  TextEditingController eventName = TextEditingController();
  TextEditingController eventStartDate = TextEditingController();
  TextEditingController eventEndDate = TextEditingController();
  TextEditingController eventCapacity = TextEditingController();
  TextEditingController eventDescription = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future choose_image_gallery() async {
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      print(imageTemp);
      setState(() => this._image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future updateImage() async {
    final uri = Uri.parse(
        "http://$ip_address/Event_Management/Organise/update_data_online.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = widget.data_user.id.toString();
    request.fields['event_name'] = eventName.text;
    request.fields['event_end_date'] = eventEndDate.text;
    request.fields['event_start_date'] = eventStartDate.text;
    request.fields['event_capacity'] = eventCapacity.text;
    request.fields['event_description'] = eventDescription.text;
    print(request.fields['name']);
    if (_image != null) {
      var pic = await http.MultipartFile.fromPath("image", _image.path);
      print("**********************************");
      print(_image);
      request.files.add(pic);
    }
    var response = await request.send();
    print(response);

    if (response.statusCode == 200) {
      print('Image Uploded');

      final snackBar = CustomSnackBar(
        content: Lottie.asset('assets/edit.json'),
        action: SnackBarAction(
          label: '',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print('Image Not Uploded');
    }
    setState(() {});
  }

  @override
  void initState() {
    eventName = TextEditingController(text: widget.data_user.event_name);
    eventEndDate = TextEditingController(text: widget.data_user.event_end_date);
    eventStartDate = TextEditingController(text: widget.data_user.event_start_date);
    eventStartDate = TextEditingController(text: widget.data_user.event_start_date);
    eventCapacity = TextEditingController(text: widget.data_user.event_capacity);
    eventDescription = TextEditingController(text: widget.data_user.event_description);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Online Event",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
            fontFamily: GoogleFonts.prompt().fontFamily,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).primaryColor,
            size: 35,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: TextFormField(
                  controller: eventName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                    ),
                    labelText: "Enter Event Name",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              // Replace the "Enter End Date" text field with a new one that includes a date picker.
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () async {
                    DateTime? selectedStartDate = eventStartDate.text.isNotEmpty
                        ? DateFormat('dd-MM-yyyy').parse(eventStartDate.text)
                        : DateTime.now();

                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedStartDate,
                      firstDate: selectedStartDate, // Set the first date to the selected start date
                      lastDate: DateTime(2100),
                    );

                    if (selectedDate != null) {
                      final formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
                      setState(() {
                        eventEndDate.text = formattedDate; // Update the event end date field
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: eventEndDate,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        labelText: "Tap to choose event end date",
                        hintText: "Tap to choose event end date",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: TextFormField(
                  controller: eventCapacity,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                    ),
                    labelText: "Enter Event Capacity",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: TextFormField(
                  controller: eventDescription,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                    ),
                    labelText: "Enter Description",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.only(
                    left: 110,
                    right: 110,
                    top: 20,
                    bottom: 20,
                  ),
                ),
                onPressed: () {
                  setState(() {});
                  updateImage();
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Display_Data_with_image()));
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    Key? key,
    required Widget content,
    SnackBarAction? action,
  }) : super(
    key: key,
    content: content,
    action: action,
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
  );
}
