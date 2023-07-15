import 'package:agricultural_insurance_system/screens/loading_screen.dart';
import 'package:flutter/material.dart';

import 'configs/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Palette.kbackgroundColor,
        primaryColor: Palette.kprimaryColor,
      ),
      home: const LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
