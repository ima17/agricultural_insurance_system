import 'package:agricultural_insurance_system/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class FilledApplicationScreen extends StatefulWidget {
  const FilledApplicationScreen({super.key});

  @override
  State<FilledApplicationScreen> createState() =>
      _FilledApplicationScreenState();
}

class _FilledApplicationScreenState extends State<FilledApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        title: "Filled Applications",
      ),
    );
  }
}
