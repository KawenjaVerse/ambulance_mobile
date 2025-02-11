import 'package:flutter/material.dart';

class DeafPage extends StatefulWidget {
  const DeafPage({super.key});

  @override
  State<DeafPage> createState() => _DeafPageState();
}

class _DeafPageState extends State<DeafPage> {
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
          
              const SizedBox(width: 90),
                // Text: "I am Deaf"
                const Text(
                  'I am Deaf',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
           const SizedBox(height: 10),
                // GridView for 4 emergency items
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2, // 2 items in each row
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _gridItem(Icons.local_hospital, 'Trauma', Colors.blue),
                      _gridItem(Icons.medical_services, 'Medical', Colors.green),
                      _gridItem(Icons.warning, 'Multi Casualty', Colors.orange),
                      _gridItem(Icons.baby_changing_station, 'Maternity', Colors.pink),
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
