import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import for Google Fonts
import 'package:girly_todo_app/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    // Show splash for 3 seconds
    await Future.delayed(const Duration(seconds: 3), () {});
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50, // A very light pink background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your big image
            ClipRRect( // ClipRRect for rounded corners on the image
              borderRadius: BorderRadius.circular(20.0), // Rounded corners for the image
              child: Image.asset(
                'assets/images/image.jpeg',
                width: 250, // Adjust size as needed
                height: 250, // Adjust size as needed
                fit: BoxFit.cover, // Or BoxFit.contain
              ),
            ),
            const SizedBox(height: 30),
            // Optional: Add a loading indicator or app title
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
              strokeWidth: 5,
            ),
            const SizedBox(height: 20),
            Text(
              'Your Girly To-Do',
              style: GoogleFonts.dancingScript(
                fontSize: 36, // Larger for splash screen
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade700,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              'Stay organized and fabulous!',
              style: GoogleFonts.quicksand(
                fontSize: 18,
                color: Colors.pink.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}