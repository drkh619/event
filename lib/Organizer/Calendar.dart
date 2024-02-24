import 'package:event_management/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:lottie/lottie.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
    print(userid);
    // print(event);
  }

  Future<void> fetchEvents() async {
    var url = "$ip_address/Event_Management/Organise/calendar.php?uid=$userid";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> eventData = jsonDecode(response.body);
      setState(() {
        events = _processEventData(eventData);
        print(eventData);
      });
    } else {
      throw Exception('Failed to load events');
    }
  }

  List<Event> _processEventData(List<dynamic> eventData) {
    List<Event> processedData = [];
    List<DateTime> processedDates = [];

    for (var event in eventData) {
      String eventStartDateStr = event['event_start_date'];
      String eventEndDateStr = event['event_end_date'];

      List<String> startDateParts = eventStartDateStr.split('-');
      int startYear = int.parse(startDateParts[2]);
      int startMonth = int.parse(startDateParts[1]);
      int startDay = int.parse(startDateParts[0]);

      List<String> endDateParts = eventEndDateStr.split('-');
      int endYear = int.parse(endDateParts[2]);
      int endMonth = int.parse(endDateParts[1]);
      int endDay = int.parse(endDateParts[0]);

      DateTime startDate = DateTime(startYear, startMonth, startDay);
      DateTime endDate = DateTime(endYear, endMonth, endDay);

      // Check if the start date has been processed already
      if (!processedDates.contains(startDate)) {
        // Add the processed date to the list to avoid repetition
        processedDates.add(startDate);

        // Add the "Event List" title and event name to the processed data
        processedData.add(
          Event(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Center(
                  child: Text(
                    "Event List",
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                    ),
                  ),
                ),
                SizedBox(height: 8), // Add some spacing between the title and event name
                Text("• " + event['event_name'],
                  style: GoogleFonts.poppins(fontSize:18,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                  ),
                ),
              ],
            ),
            dateTime: CalendarDateTime(
              year: startDate.year,
              month: startDate.month,
              day: startDate.day,
              calendarType: CalendarType.GREGORIAN, // Assuming the dates are in Gregorian calendar
            ),
          ),
        );
      } else {
        // If the start date has already been processed, add only the event name
        processedData.add(
          Event(
            child: Text("• " + event['event_name'],
              style: TextStyle(fontSize: 22),
            ),
            dateTime: CalendarDateTime(
              year: startDate.year,
              month: startDate.month,
              day: startDate.day,
              calendarType: CalendarType.GREGORIAN, // Assuming the dates are in Gregorian calendar
            ),
          ),
        );
      }
    }

    return processedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: EventCalendar(
            calendarType: CalendarType.GREGORIAN,
            calendarOptions: CalendarOptions(
              bottomSheetBackColor: Colors.black87,
              toggleViewType: true,
              headerMonthBackColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.purple.shade100
                  : Colors.teal.shade100,
            ),// Use GREGORIAN if you're using the standard Gregorian calendar
            headerOptions: HeaderOptions(
              weekDayStringType: WeekDayStringTypes.SHORT,
            ),
            eventOptions: EventOptions(
              emptyText: "No events on this date",
              emptyIcon: Icons.not_interested
            ),
            events: events,
          ),
        ),
      ),
    );
  }
}
