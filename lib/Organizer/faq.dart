import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FAQ',style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Lottie.asset(
                Theme.of(context).brightness == Brightness.dark ? 'assets/faqdark.json' : 'assets/faq.json', // Replace with the path to your lottie animation file
                width: 250, // Adjust the width as needed
                height: 250,
                fit: BoxFit.fill,
              ),
            ),
            FAQItem(
              question: 'Q: What is EVENT.IO?',
              answer:
              'A: EVENT.IO is an app for event booking and registration. It allows you to discover, explore, register, share, and provide feedback for a variety of events. It also allows you to create and manage events, manage tickets and attendees, and access analytics and reporting.',
            ),
            FAQItem(
              question: 'Q: How do I create an account on EVENT.IO?',
              answer:
              'A: You can create an account on EVENT.IO by downloading the app from the App Store or Google Play Store and following the instructions on the screen. You can also sign up using your email address or your social media accounts.',
            ),
            FAQItem(
              question: 'Q: How do I search for events on EVENT.IO?',
              answer:
              'A: You can search for events on EVENT.IO by using the search bar on the home screen. You can also filter events by category, location, date, and price. You can also browse events by popularity, rating, or recommendation.',
            ),
            FAQItem(
              question: 'Q: How do I register for events on EVENT.IO?',
              answer:
              'A: You can register for events on EVENT.IO by tapping on the event you are interested in and selecting the ticket option you prefer. You can then proceed to the payment screen where you can enter your payment details and confirm your registration. You will receive a confirmation email with your registration details and a QR code that you can use to access the event.',
            ),
            FAQItem(
              question: 'Q: How do I share events on EVENT.IO?',
              answer:
              'A: You can share events on EVENT.IO by tapping on the share icon on the event page. You can then choose the social media platform you want to share the event on.',
            ),
            FAQItem(
              question: 'Q: How do I provide feedback and reviews on EVENT.IO?',
              answer:
              'A: You can provide feedback and reviews on EVENT.IO by tapping on the feedback icon on the event page. You can then rate the event from 1 to 5 stars and leave a comment about your experience. You can also see what other attendees have to say about the event.',
            ),
            FAQItem(
              question: 'Q: How do I integrate my events with my calendar platforms on EVENT.IO?',
              answer:
              'A: You can integrate your events with your calendar platforms on EVENT.IO by tapping on the calendar icon on the event page. You can then choose the calendar platform you want to add the event to. The event details will be automatically added to your calendar.',
            ),
            FAQItem(
              question: 'Q: How do I create and manage events on EVENT.IO?',
              answer:
              'A: To create and manage events on EVENT.IO, you need to be an organizer. You can sign up an Organizer account you can access the organizer dashboard where you can create and manage events, manage tickets and attendees, and access analytics and reporting.',
            ),
            FAQItem(
              question: 'Q: How do I contact support on EVENT.IO?',
              answer:
              'A: If you have any questions or issues with using our app, you can contact us at support@event.io. We will be happy to assist you. You can also visit our help and support section where you can find answers to common questions and issues.',
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: GoogleFonts.poppins(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          answer,
          style: GoogleFonts.poppins(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
        Divider(),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FAQPage(),
  ));
}
