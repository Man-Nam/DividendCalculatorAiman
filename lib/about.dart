// lib/about.dart
import 'package:flutter/material.dart';
import 'package:individualassignmentmobile/home.dart'; // Make sure this path is correct
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  // Helper to show a SnackBar for errors
  // This function is now defined within the class but outside build, making it callable.
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Function to launch URL
  Future<void> _launchUrl(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Could not launch $url'); // For developer debugging
      // Use the helper function to show the error
      _showError(context, 'Could not open the link. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define your information
    const String authorName = 'Muhammad Aiman Fakhry Bin Mohamed Radzi';
    const String matricNo = '2023516205';
    const String course = 'RCDCS2515A';
    const String githubUrl = 'https://github.com/Man-Nam/DividendCalculatorAiman.git';
    const String copyrightYear = '2025';

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // App Icon/Logo
              Image.asset(
                'assets/images/logo.png', // Ensure this path is correct and logo.png exists
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Dividend Calculator',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Author Information
              const Text(
                'Author Information:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Name: $authorName',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                'Matric No: $matricNo',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                'Course: $course',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Copyright Notice
              Text(
                '© $copyrightYear $authorName. All rights reserved.',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // GitHub Repository Link
              const Text(
                'Visit our GitHub Repository:',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              InkWell(
                // Corrected call to _launchUrl by passing context
                onTap: () => _launchUrl(context, githubUrl),
                child: Text(
                  githubUrl,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // Drawer for sidebar navigation (unchanged)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Dividend Calculator',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}