import 'package:agricultural_insurance_system/screens/recording_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green, // Set the primary color to green
      ),
      home: const RecordingScreen(),
      debugShowCheckedModeBanner: false, // Hide the debug banner
    );
  }
}
