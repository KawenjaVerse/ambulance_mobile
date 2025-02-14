import 'package:ambulance_app/Authentication/RegisterPage.dart';
import 'package:ambulance_app/Home/HomePage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AmbulanceServicesPage extends StatefulWidget {
  const AmbulanceServicesPage({super.key});

  @override
  _AmbulanceServicesPageState createState() => _AmbulanceServicesPageState();
}

class _AmbulanceServicesPageState extends State<AmbulanceServicesPage> {
  int currentIndex = 0; // Track the current carousel index

  final List<Map<String, String>> services = [
    {
      'title': 'SOS Emergency Response',
      'description': 'Our ambulances provide fast emergency response for accidents and critical health issues.',
    },
    {
      'title': 'Medical Transport',
      'description': 'We ensure safe and comfortable transport for non-emergency medical appointments and transfers.',
    },
    {
      'title': '24/7 Availability',
      'description': 'Our ambulance services are available 24/7, ensuring medical help anytime, anywhere.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Image with Clipped Bottom
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              width: double.infinity,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/city.avif'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const Spacer(), 
          // Carousel Slider
          CarouselSlider(
            options: CarouselOptions(
              height: 150,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: services.map((service) {
              return Container(
                height: 300,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      service['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      service['description']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 10),

          // Smooth Page Indicator
          DotsIndicator(
            dotsCount: services.length,
            position: currentIndex,
            decorator: DotsDecorator(
              size: const Size(8, 8),
              activeSize: const Size(14, 8),
              activeColor: Colors.red.shade900,
              color: Colors.grey.shade400,
              spacing: const EdgeInsets.all(4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
          ),

          const SizedBox(height: 15),

          // Forward Arrow Button
          Padding(
            padding: const EdgeInsets.only(bottom: 40), // Adjust bottom padding
            child: GestureDetector(
              onTap: () async {
                // Add navigation logic here


                await SharedPreferences.getInstance().then((prefs) {
                  prefs.setBool('ambulance_services_seen', true);
                });

                 Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPage()),
      );
   
              },
              child: const CircleAvatar(
                radius: 30,
                backgroundColor: const Color.fromARGB(255, 172, 31, 21),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for Bottom Curved Image
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(size.width / 2, size.height + 20, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
