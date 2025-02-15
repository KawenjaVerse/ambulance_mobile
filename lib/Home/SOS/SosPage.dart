import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../AmbulanceService.dart';
import '../../Authentication/RegisterPage.dart';

class SosPage extends StatefulWidget{
  @override
  State<SosPage> createState() {
    return _SosPage();
  }

}

class _SosPage extends State<SosPage>{
  int currentIndex = 0; // Track the current carousel index
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(

        children: [
          Positioned(top: -50, right: -50, child: CustomRingWidget()),
          Positioned(bottom: -50, left: -50, child: CustomRingWidget()),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center ,
              children: [
                const SizedBox(height: 40), // Adjust for status bar

                // Back Arrow
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context); // Go back to the previous screen
                      },
                    ),


                  ],
                ),
                const SizedBox(height: 10),

                // Text: "What's your emergency"
                Center(
                  child: const Text(
                    "What's your emergency?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),

                // Emergency Image (use an actual image here)
                Center(
                  child: Image.asset(
                    'assets/images/emerg.png', // Replace with your emergency image
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text('About',style: TextStyle(fontWeight: FontWeight.bold),),
                ),

                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2, // 2 items in each row
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _gridItem(Icons.local_hospital, 'Find Blood', Colors.red),
                      _gridItem(Icons.medical_services, 'Find Ambulance', Colors.red),
                      _gridItem(Icons.warning, 'First Aid Experts', Colors.red),
                      _gridItem(Icons.baby_changing_station, 'Medical Equipment', Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create grid items
  Widget _gridItem(IconData icon, String label, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      elevation: 4, // Adds a shadow effect for depth
      color: Colors.white, // Card background color
      child: InkWell(
        onTap: () {
          // Add onTap functionality if needed
        },
        borderRadius: BorderRadius.circular(12.0), // Same rounded corners as Card
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding inside the card
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 35, // Size of the avatar
                backgroundColor: color, // Background color
                child: Icon(
                  icon,
                  size: 40, // Icon size
                  color: Colors.white, // Icon color
                ),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13, // Slightly larger font size
                  fontWeight: FontWeight.w500, // Medium weight
                  color: Colors.black, // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}