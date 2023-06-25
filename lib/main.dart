//import 'package:agricultural_insurance_system/screens/recording_screen.dart';
import 'package:agricultural_insurance_system/screens/recording_screen.dart';
//import 'package:agricultural_insurance_system/screens/risks_show_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green, 
      ),
      home: const RecordingScreen(),
      debugShowCheckedModeBanner: false, 
    );
  }
}
