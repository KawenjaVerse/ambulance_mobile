import 'package:ambulance_app/SplashPage.dart';
import 'package:ambulance_app/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../Home/HomePage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: _buildNamePage()),
    );
  }

  var _formKey = GlobalKey<FormState>();
  var _name = "";
  var _email = "";
  var _phone = "";
  var _password = "";

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
          const Text("Create an account with us", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),

          // Subtitle
          const Text("Fill the details below to continue", style: TextStyle(fontSize: 16, color: Colors.grey)),
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
            child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(children: [

                        artyTechTextInput("Name", (value){
                          _name = value;
                        }, prefixIcon: Icons.person),

                        artyTechTextInput("Email", (value){
                          _email = value;
                        },prefixIcon: Icons.mail),
                        artyTechTextInput("Phone", (value){
                          _phone = value;
                        },prefixIcon: Icons.phone),

                        artyTechTextInput("Password", (value){
                          _password = value;
                        },prefixIcon: Icons.lock),

                    ],),
                    ),
                  ),





          ),
          const SizedBox(height: 10),

         
          const SizedBox(height: 30),

          // Next Button
          _loading ? const Center(child: CircularProgressIndicator()) :
          _buildNextButton(() {
            _formKey.currentState!.save();
            registerPerson();
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
        child: const Text("Register", style: TextStyle(fontSize: 18, color: Colors.white)),
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

  var _loading = false;
  void registerPerson() {
    _formKey.currentState!.save();

    requestAPI("people/register", {
      "name": _name,
      "email": _email,
      "phone": _phone,
      "password": _password,
      "address": "",
      "country": "Philippines",
      "city": "Manila",
    }, (loading){
      setState(() {
        _loading = loading;
      });
    }, (value){
      if (value["status"] == "success") {
        savePersonInPreference(value["data"]);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SplashScreen()), (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value["message"]),
          backgroundColor: Colors.red,
        ));
      }
    }, (error){}, method: "POST");

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
