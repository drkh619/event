import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

import '../main.dart';


class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  List<dynamic> analyticsData = [];
  // String orgId = '11'; // Replace with your actual organiser ID


  @override
  void initState() {
    super.initState();
    fetchAnalyticsData();
  }

  Future<void> fetchAnalyticsData() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    var ui = await sharedprefs.getString('organizer_uid');
    try {
      print("hello"+ui!);
      final response = await http.post(
          Uri.parse('$ip_address/Event_Management/Organise/analytics.php'),
          body: {'orgId': ui});

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        setState(() {
          analyticsData = decodedData;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error fetching data: HTTP ${response.statusCode}'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching data: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event Analytics",
          style: GoogleFonts.inter(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
      body: analyticsData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text('Event Type', style: TextStyle(fontWeight: FontWeight.bold)),
              // Text('Ticket Count', style: TextStyle(fontWeight: FontWeight.bold)),
              // Text('Total Revenue', style: TextStyle(fontWeight: FontWeight.bold)),
              // Text('Latest Purchase Date', style: TextStyle(fontWeight: FontWeight.bold)),
              // Divider(),
              for (var item in analyticsData) AnalyticsItem(item),
              SizedBox(height: 20),
              Text('Performance', style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black))),
              Container(
                height: 300, // Adjust the height as needed
                child: PieChart(
                  PieChartData(
                    sections: List.generate(
                      analyticsData.length,
                          (index) => PieChartSectionData(
                        value: double.parse(analyticsData[index]['ticket_count'].toString()),
                        title: (analyticsData[index]['event_type'] == 'offline_event') ? 'Offline Event' : 'Online Event',
                        color: _getChartColor(index),
                        radius: 80,
                      ),
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,

                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Revenue', style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black))),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300, // Adjust the height as needed
                  child: Center(
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: getMaxRevenue()+5000,
                        barGroups: List.generate(
                          analyticsData.length,
                              (index) => BarChartGroupData(
                                x: index,
                            barRods: [
                              BarChartRodData(
                                y: double.parse(analyticsData[index]['total_revenue'].toString()),
                                colors: [_getChartColor(index)],
                              ),
                            ],
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: SideTitles(showTitles: true, getTextStyles: (context, value) => TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                          ),),
                          rightTitles: SideTitles(showTitles: true, getTextStyles: (context, value) => TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                        ),),
                          bottomTitles: SideTitles(
                            showTitles: true,
                            getTitles: (value) => (analyticsData[value.toInt()]['event_type'] == 'offline_event') ? 'Offline Event' : 'Online Event',
                            getTextStyles: (context, value) => TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text('Total Revenue', style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black))),
              SizedBox(height: 20,),
              Container(
                height: 80,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.purple.shade100
                      : Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '₹${NumberFormat('#,##,###').format(getTotalRevenue())}',
                      style: GoogleFonts.mulish(textStyle: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.black87)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Color getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  double getMaxRevenue() {
    return analyticsData.isNotEmpty
        ? analyticsData.map((data) => double.parse(data['total_revenue'])).reduce((a, b) => a > b ? a : b)
        : 100.0; // Default max value
  }
  double getTotalRevenue() {
    return analyticsData.isNotEmpty
        ? analyticsData.map((data) => double.parse(data['total_revenue'])).reduce((a, b) => a + b)
        : 0.0; // Default total revenue value
  }
}

class AnalyticsItem extends StatelessWidget {
  final Map<String, dynamic> item;

  AnalyticsItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.purple.shade100
          : Colors.teal.shade100,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (item['event_type'] == "offline_event") ? "Offline Event" : "Online Event",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tickets: ${item['ticket_count']}',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(height: 4),
            Text(
              'Revenue: ₹${NumberFormat('#,##,###').format(double.parse(item['total_revenue']))}',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(height: 4),
            Text(
              'Latest Purchase Date: ${item['latest_purchase_date']}',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),

          ],
        ),
      ),
    );


  }
}
Color _getChartColor(int index) {
  // Customize the chart section colors (light purple and light blue)
  if (index % 2 == 0) {
    return Color(0xFFB280FF).withOpacity(0.8); // Light Purple
  } else {
    return Color(0xFF6BDCFF).withOpacity(0.8); // Light Blue
  }
}
double getTotalRevenue() {
  List<dynamic> analyticsData = [];
  return analyticsData.isNotEmpty
      ? analyticsData.map((data) => double.parse(data['total_revenue'])).reduce((a, b) => a + b)
      : 0.0; // Default total revenue value
}