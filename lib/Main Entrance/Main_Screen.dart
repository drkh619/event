import 'package:flutter/material.dart';
import 'package:event_management/Organizer/Organizer_Splash_Screen.dart';
import 'package:event_management/User/User_Splash_Screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Admin/Splash_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flowing Gradient',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<List<Color>> gradientColorSets = [
    [Color(0xFFE91E63), Color(0xFF880E4F)], // Magenta-pink
    [Color(0xFFD84397), Color(0xFFB63BC1)], // Purple-pink
    [Color(0xFFB63BC1), Color(0xFFD84397)], // Pink-purple
    [Color(0xFF4A148C), Color(0xFF7B1FA2)], // Deep purple
    [Color(0xFF039BE5), Color(0xFF3F51B5)], // Blue
    [Color(0xFF00897B), Color(0xFF26A69A)], // Teal
  ]; // Gradient color sets

  int currentColorSetIndex = 0; // Index of the current gradient color set

  @override
  void initState() {
    super.initState();
    _startGradientAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedContainer(
        duration: Duration(seconds: 5), // Duration of the gradient animation
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColorSets[currentColorSetIndex], // Use the current gradient colors
          ),
        ),
        child: Stack(
          children: [
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   child: Image.asset(
            //     "assets/leaf.png",
            //     height: 250,
            //     width: 450,
            //     fit: BoxFit.fill,
            //   ),
            // ),
            Center(
              child: Column(
                children: [
                  Spacer(flex: 2),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "EVENT.IO",
                      style: GoogleFonts.poppins(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your Event Management Partner",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    "assets/event.png",
                    height: 220,
                    width: 220,
                    fit: BoxFit.contain,
                  ),
                  Spacer(flex: 2),
                  _buildButton(
                    context,
                    'ADMIN',
                    Icons.admin_panel_settings,
                    Color(0xFF007AFF),
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Splash_Screen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  _buildButton(
                    context,
                    'User',
                    Icons.person,
                    Color(0xFFFF9500),
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => User_Splash_Screen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  _buildButton(
                    context,
                    'Organizer',
                    Icons.event,
                    Color(0xFF4CD964),
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Organizer_Splash_Screen(),
                        ),
                      );
                    },
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context,
      String text,
      IconData icon,
      Color color,
      VoidCallback onPressed,
      ) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startGradientAnimation() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        currentColorSetIndex = (currentColorSetIndex + 1) % gradientColorSets.length;
        _startGradientAnimation();
      });
    });
  }
}
