import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../Home/HomePage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = "+1"; // Default country code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Decorations (Light Colored Rings)
          Positioned(top: -50, right: -50, child: CustomRingWidget()),
          Positioned(bottom: -50, left: -50, child: CustomRingWidget()),

          // PageView for step-by-step registration
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Prevent swipe navigation
            children: [
              _buildNamePage(),
              _buildPhonePage(),
            ],
          ),
        ],
      ),
    );
  }

  // Step 1: Enter Name
  Widget _buildNamePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           const SizedBox(height: 40), // Adjust for status bar

          // Back Arrow
          IconButton(
            icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),

          const SizedBox(height: 40),

          // Title
          const Text("Name", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),

          // Subtitle
          const Text("Please enter your name", style: TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 20),

          // White Container with Text
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter your name", style: TextStyle(fontSize: 16, color: Colors.black54)),
                const SizedBox(height: 10),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
             
              
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
              ],
            ),
          ),
          const SizedBox(height: 10),

         
          const SizedBox(height: 30),

          // Next Button
          _buildNextButton(() {
            if (_nameController.text.isNotEmpty) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          }),
          _buildTermsText(),
        ],
      ),
    );
  }

  // Step 2: Enter Mobile Number
  Widget _buildPhonePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Title
          const SizedBox(height: 40), // Adjust for status bar

          // Back Arrow
          IconButton(
            icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),

          const SizedBox(height: 40),
          const Text("Mobile Number", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),

          // Subtitle
          const Text("Please enter your mobile number", style: TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 20),

          // White Container with Text
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter your mobile number", style: TextStyle(fontSize: 16, color: Colors.black54)),

                 const SizedBox(height: 10),

          // Phone Number Input Field with Country Code
          Row(
            children: [
              // Country Code Picker
              CountryCodePicker(
                onChanged: (country) {
                  setState(() {
                    _selectedCountryCode = country.dialCode!;
                  });
                },
                initialSelection: "US",
                favorite: ["+1", "+256"], // Include Uganda 🇺🇬 as an option
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
              ),
              const SizedBox(width: 10),

              // Phone Number Input
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                   
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
              ],
            ),
          ),
         
          const SizedBox(height: 30),

          // Next Button
          _buildNextButton(() {
            // Navigate to home page
            if (_phoneController.text.isNotEmpty) {
             Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
            }
           
          }),
          _buildTermsText(),
        ],
      ),
    );
  }

  // Reusable Next Button
  Widget _buildNextButton(VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
        ),
        child: const Text("Next", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  // Terms & Privacy Text
  Widget _buildTermsText() {
    return const Padding(
      padding: EdgeInsets.only(top: 15),
      child: Text(
        "By continuing you agree to our Terms of Service and Privacy Policy",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}

// Custom Widget for Light Rings Background
class CustomRingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RingPainter(),
      size: const Size(120, 120),
    );
  }
}

// Painter for Light Rings
class RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.shade100.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    // Draw three rings with different sizes
    canvas.drawCircle(size.center(Offset.zero), size.width / 3, paint);
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
    canvas.drawCircle(size.center(Offset.zero), size.width / 1.5, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
