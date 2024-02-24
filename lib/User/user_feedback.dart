import 'package:event_management/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _feedbackController = TextEditingController();
  bool _isFeedbackAllowed = true;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _checkFeedbackAllowed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We\'d love to hear your feedback!',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black

              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                labelText: 'Your feedback',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences, // Capitalize first letter of each sentence
              textInputAction: TextInputAction.done, // Change keyboard action to Done
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _isFeedbackAllowed ? _submitFeedback : null,
                // Disable the button if feedback submission is not allowed
                style: ElevatedButton.styleFrom(
                  primary: _isFeedbackAllowed ? Theme.of(context).primaryColor : Colors.grey, // Change button color based on feedback submission allowance
                  elevation: 3, // Add some elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Set button border radius
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _checkFeedbackAllowed() async {
    final lastSubmissionTimestamp = _prefs.getInt('last_submission_timestamp_user') ?? 0;
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    final differenceInDays = (currentTimestamp - lastSubmissionTimestamp) ~/ (1000 * 60 * 60 * 24);

    setState(() {
      _isFeedbackAllowed = differenceInDays >= 7;
    });
  }


  Future<void> _submitFeedback() async {
    final String url = '$ip_address/Event_Management/feedback.php';

    // Send the feedback to the server
    final response = await http.post(
      Uri.parse(url),
      body: {
        'feedback': _feedbackController.text,
        'uid': user_Id,
        'type':'User',
        'user':username_user,
        // Add any additional parameters needed for the API
      },
    );

    if (response.statusCode == 200) {
      // Handle successful feedback submission
      setState(() {
        _isFeedbackAllowed = false; // Disable feedback submission
      });
      _prefs.setInt('last_submission_timestamp', DateTime.now().millisecondsSinceEpoch);
      // Display a confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Feedback Submitted'),
            content: Column(
              children: [
                buildLottieAnimation(),
                Text('Thank you for your feedback!'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle errors if any
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit feedback. Please try again later.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}
Widget buildLottieAnimation() {
  return Container(
    height: 200, // Adjust the height as needed
    width: 200, // Adjust the width as needed
    child: Lottie.asset('assets/thanks.json'),
  );
}