import 'package:agricultural_insurance_system/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'configs/palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Palette.kBackgroundColor,
        primaryColor: Palette.kPrimaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Palette.kPrimaryColor),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          color: Palette.kPrimaryColor,
        ),
        // useMaterial3: true,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
