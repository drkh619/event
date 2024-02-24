import 'dart:convert';
import 'package:event_management/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminFeedbackPage extends StatefulWidget {
  @override
  _AdminFeedbackPageState createState() => _AdminFeedbackPageState();
}

class _AdminFeedbackPageState extends State<AdminFeedbackPage> {
  List<Map<String, dynamic>> _feedbackList = [];

  @override
  void initState() {
    super.initState();
    _fetchFeedbacks();
  }

  Future<void> _fetchFeedbacks() async {
    final url = '$ip_address/Event_Management/Admin/view_feedback.php'; // Replace this with your API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        setState(() {
          _feedbackList = data.cast<Map<String, dynamic>>();
        });
      } else {
        // Handle error if any
        print('Failed to load feedbacks: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors
      print('Error fetching feedbacks: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Feedbacks'),
      ),
      body: _feedbackList.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _feedbackList.length,
        itemBuilder: (context, index) {
          final feedback = _feedbackList[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(feedback['user'] + "(" + feedback['type'] + ")"),
              subtitle: Text(feedback['feedback']),
              // Additional fields from feedback data can be displayed here
            ),
          );
        },
      ),
    );
  }
}
