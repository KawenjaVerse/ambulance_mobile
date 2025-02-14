import 'dart:async';

import 'package:ambulance_app/Home/ContactUs/ContactUsPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'DeafPage.dart'; // Google Maps package

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Drawer (Burger menu)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text('Hi User'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            ),
            ListTile(
              title: Text('Log Out'),
              leading: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),

      // AppBar
      appBar: AppBar(
        title: const Text('Hi User'),
        backgroundColor: Colors.red,
        elevation: 0,
        foregroundColor: Colors.white,
      ),

      // Body with map and bottom navbar
      body: Stack(
        children: [
          // Google Map
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),

          // Round red SOS button at the center above the bottom navbar
          Positioned(
            bottom: 160, // Adjust position
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: _showSOSDialog,
                child: CircleAvatar(
                  radius: 60, // Size of the avatar
                  backgroundColor: Colors.red,
                  child: const Text('SOS', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ),
          ),

          // Bottom Navbar with curved shape near SOS button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 150, // Adjusted height for better layout
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: _bottomNavItem(Icons.medical_services, 'E-services', Colors.blue)),
                  _bottomNavItem(Icons.location_on, 'Nearby', Colors.green),
                  GestureDetector(
                     onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DeafPage()));
                    },
                    child: _bottomNavItem(Icons.accessibility, 'I am Deaf', Colors.orange)),
                  GestureDetector(
                      child: _bottomNavItem(Icons.support_agent, 'Support', Colors.red),
                      onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsPage() ) );
                      }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Navbar Item with circular avatar and colored background
  Widget _bottomNavItem(IconData icon, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: color,
          child: Icon(icon, size: 30, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black)),
      ],
    );
  }

  // SOS Button AlertDialog
  void _showSOSDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Emergency activation'),
          content: Column(
           mainAxisSize: MainAxisSize.min, // To fit the content size
            children: [
              // First row with Mobile Shake
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/icons8-shake-phone-100.png'), // Add your image path
                  ),
                  const SizedBox(width: 10),
             Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Mobile Shake', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                      Text('''Shake your Phone thrice to 
generate SOS Emergency Request.'''
                      , style: TextStyle(fontSize: 11,color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Second row with Gesture Activation
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/icons8-hand-drag-100.png'), // Add your image path
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Gesture Activation', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                      Text('''Request emergency bt swiping three
fingers down on Home screen''', style: TextStyle(fontSize: 11,color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Skip'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Enable Now',style: TextStyle(color: Color.fromARGB(255, 91, 14, 8)),),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
