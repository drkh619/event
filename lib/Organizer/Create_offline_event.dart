  import 'dart:io';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:http/http.dart' as http;
  import 'package:image_picker/image_picker.dart';
  import 'package:intl/intl.dart';
  import 'package:lottie/lottie.dart';

  import '../../main.dart';
  import 'Organizer_Home_Page.dart';

  class Create_offline_event extends StatefulWidget {
    @override
    _Create_offline_eventState createState() => _Create_offline_eventState();
  }

  class _Create_offline_eventState extends State<Create_offline_event> with SingleTickerProviderStateMixin {
  //here
  //lottie animation controller start
    late final AnimationController _controller;
    @override
    void initState() {
      super.initState();

      _controller = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this,
      );
    }

    @override
    void dispose() {
      super.dispose();
    }

    bool submited = false;

    Future<void> navigateToHomePage() async {
      // Delay navigation by 5 seconds
      await Future.delayed(Duration(seconds: 7));

      // Navigate back to the Organizer_Home_Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Organizer_HomePage(),
        ),
      );
    }
    //here

    var _image;
    ImagePicker picker = ImagePicker();

    TextEditingController eventName = TextEditingController();
    TextEditingController eventStartDate = TextEditingController();
    TextEditingController eventEndDate = TextEditingController();
    TextEditingController eventVenue = TextEditingController();
    TextEditingController eventPrice = TextEditingController();
    TextEditingController eventCapacity = TextEditingController();
    TextEditingController eventDescription = TextEditingController();

    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

    Future chooseImageGallery() async {
      setState(() {
        _image = null; // Clear the image
      });

      try {
        final image = await picker.pickImage(source: ImageSource.gallery);

        if (image == null) return;

        final imageTemp = File(image.path);

        setState(() => this._image = imageTemp);
      } catch (e) {
        print('Failed to pick image: $e');
      }
    }

    Future chooseImageCamera() async {
      setState(() {
        _image = null; // Clear the image
      });

      try {
        final image = await ImagePicker.platform.pickImage(source: ImageSource.camera);

        if (image == null) return;

        final imageTemp = File(image.path);

        setState(() => this._image = imageTemp);
      } catch (e) {
        print('Failed to pick image: $e');
      }
    }

    Future uploadImage() async {
      final uri = Uri.parse("http://$ip_address/Event_Management/Organise/Create_offline_event.php");
      var request = http.MultipartRequest('POST', uri);
      request.fields['event_name'] = eventName.text;
      request.fields['event_start_date'] = eventStartDate.text;
      request.fields['event_end_date'] = eventEndDate.text;
      request.fields['event_venue'] = eventVenue.text;
      request.fields['event_price'] = eventPrice.text;
      request.fields['event_capacity'] = eventCapacity.text;
      request.fields['event_description'] = eventDescription.text;
      request.fields['uid'] = userid;

      var pic = await http.MultipartFile.fromPath("event_image", _image.path);
      request.files.add(pic);
      var response = await request.send();
      print(response);

      if (response.statusCode == 200) {
        print('Image Uploaded');
        // Clear form fields and image
        eventName.clear();
        eventStartDate.clear();
        eventEndDate.clear();
        eventVenue.clear();
        eventPrice.clear();
        eventCapacity.clear();
        eventDescription.clear();
        setState(() {
          // _image = null;
        });

        final snackBar = CustomSnackBar(
          content: Lottie.asset('assets/submit.json'),
          action: SnackBarAction(
            label: '',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        print('Image Not Uploaded');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Offline Event",
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
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: TextFormField(
                    controller: eventName,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
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
                      labelText: "Enter event name",
                      hintText: "Enter event name",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (selectedDate != null) {
                        final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                        setState(() {
                          eventStartDate.text = formattedDate; // Update the event date field
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: eventStartDate,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
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
                          labelText: "Tap to choose event start date",
                          hintText: "Tap to choose event start date",
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
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(
                    onTap: () async {
                      DateTime? selectedStartDate = eventStartDate.text.isNotEmpty
                          ? DateFormat('yyyy-MM-dd').parse(eventStartDate.text)
                          : DateTime.now();

                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedStartDate,
                        firstDate: selectedStartDate, // Set the first date to the selected start date
                        lastDate: DateTime(2100),
                      );

                      if (selectedDate != null) {
                        final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
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
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: TextFormField(
                    controller: eventVenue,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
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
                      labelText: "Enter event venue",
                      hintText: "Enter event venue",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: TextFormField(
                    controller: eventPrice,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
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
                      labelText: "Enter ticket price",
                      hintText: "Enter ticket price",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: TextFormField(
                    controller: eventCapacity,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
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
                      labelText: "Enter ticket capacity",
                      hintText: "Enter ticket capacity",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: TextFormField(
                    controller: eventDescription,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
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
                      labelText: "Enter event description",
                      hintText: "Enter event description",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Choose Image",
                      style: GoogleFonts.hindVadodara(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.photo_outlined,
                        size: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        chooseImageGallery();
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        chooseImageCamera();
                      },
                    ),
                  ],
                ),
                // Submit button as a static teal button

                Center(
                  child: Container(
                      height: 100,
                      width: 200,
                      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),  color: Colors.grey,
                      //),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: _image != null
                            ? Image.file(
                          _image,
                          fit: BoxFit.cover,
                        )
                            : Center(
                            child: Text(
                              "No image selected",
                              style: GoogleFonts.hindVadodara(
                                  fontSize: 13, color: Colors.red.shade900),
                            )),
                      )),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      uploadImage();
                      if (submited == false) {
                        _controller.forward();
                        navigateToHomePage();
                      } else {
                        _controller.stop();
                      }
                    },
                    child: Transform.translate(
                      offset: Offset(0.0, -50.0), // Adjust the Y offset as needed
                      child: Lottie.asset(
                        Theme.of(context).brightness == Brightness.dark ? 'assets/submitbuttondark.json' : 'assets/submitbutton.json',
                        height: 250,
                        width: 250,
                        controller: _controller,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
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
      backgroundColor: Colors.transparent, // Set the background color to transparent
      elevation: 0, // Remove elevation
      behavior: SnackBarBehavior.floating, // Make it floating
    );
  }