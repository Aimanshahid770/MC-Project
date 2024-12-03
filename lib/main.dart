import 'package:flutter/material.dart';
import 'screens/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Readify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage() // Set the LandingPage as the home screen
    );
  }
}
