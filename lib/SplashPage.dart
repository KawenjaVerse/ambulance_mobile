import 'dart:async';
import 'package:flutter/material.dart';
import 'AmbulanceService.dart';
import 'Home/HomePage.dart'; // Ensure this import points to your HomePage

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the main screen after 20 seconds
    Timer(const Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AmbulanceServicesPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 31, 21), // Light red background
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100), // Space above "SOS"
          // Centered "SOS" with circular avatar for "O"
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'S',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/ecg.webp', // Replace with your image path
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text(
                'S',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20), // Space between "SOS" and the row below
Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Container(
  width: 70,
  height: 70,
  padding: const EdgeInsets.all(5),
  decoration: BoxDecoration(
    shape: BoxShape.circle, // Makes it circular
    color: Colors.white, // Background color (adjust as needed)
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3), // Adds a subtle shadow
      ),
    ],
  ),
  child: ClipOval(
    child: Image.asset(
      'assets/images/speaker.avif', // Replace with your image path
      fit: BoxFit.cover, // Ensures the image covers the circular area
    ),
  ),
),
              const SizedBox(width: 16),
              const Text(
                'iCanSave Health Alert App',
                style: TextStyle(
                  fontSize: 14,
                  
                  color: Colors.white, // White text for better contrast
                ),
              ),
            ],
          ),

    
   
          // Row with logo and "Government of Philippines"
             const Spacer(), 
              // Pushes the ambulance section to the bottom
          // Clipper Container with a Curved Top
          ClipPath(
            clipper: TopCurveClipper(),
            child: Container(
              color: const Color.fromARGB(255, 124, 11, 11), // Dark red background
              height: 300,
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/splash.webp', // Replace with your ambulance image path
                    width: 250,
                    height: 250,
                  ),
                  SizedBox(height: 15),
                  Center(
            child: Text(
              'Afrosoft IT Solutions',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
                ],
              ),
            ),
          ),
          
         
        ],
      ),
    );
  }
}

// Custom Clipper for a Curved Top
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 50);
    path.quadraticBezierTo(size.width / 2, 0, size.width, 50);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
