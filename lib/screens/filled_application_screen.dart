import 'dart:convert';

import 'package:agricultural_insurance_system/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/value_object_data.dart';

class FilledApplicationScreen extends StatefulWidget {
  const FilledApplicationScreen({Key? key}) : super(key: key);

  @override
  State<FilledApplicationScreen> createState() =>
      _FilledApplicationScreenState();
}

class _FilledApplicationScreenState extends State<FilledApplicationScreen> {
  List<ValueObject> values = [];

  @override
  void initState() {
    super.initState();
    retrieveValues();
  }

  Future<void> retrieveValues() async {
    // Retrieve the JSON string from local storage
    // Example using shared_preferences package:
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('values');

    if (jsonString != null) {
      final jsonValues = jsonDecode(jsonString) as List<dynamic>;
      values = jsonValues
          .map((jsonValue) => ValueObject.fromJson(jsonValue))
          .toList();

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        title: "Filled Applications",
      ),
      body: ListView.builder(
        itemCount: values.length,
        itemBuilder: (context, index) {
          final value = values[index];
          return ListTile(
            title: Text(value.title),
            subtitle: Text(value.value),
            leading: Icon(value.icon),
          );
        },
      ),
    );
  }
}

// IconData iconDataFromString(String iconString) {
//   int codePoint = int.parse(iconString, radix: 16);
//   return IconData(codePoint, fontFamily: 'FontAwesome');
// }
