import 'dart:convert';

import 'package:agricultural_insurance_system/widgets/custom_app_bar.dart';
import 'package:agricultural_insurance_system/widgets/filled_application_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final prefs = await SharedPreferences.getInstance();

    // Get all the keys in the local storage
    final keys = prefs.getKeys();

    // Filter the keys to get the ones that start with 'values_'
    final applicationKeys = keys.where((key) => key.startsWith('values_'));

    // Retrieve the Policy Number and Name for each relevant application
    values = [];
    for (final key in applicationKeys) {
      final jsonString = prefs.getString(key);
      if (jsonString != null) {
        final jsonValues = jsonDecode(jsonString) as List<dynamic>;
        final applicationValues = jsonValues
            .map((jsonValue) => ValueObject.fromJson(jsonValue))
            .toList();

        // Find the ValueObject with the Policy Number and Name
        final policyNumberValue = applicationValues.firstWhere(
          (value) => value.title == 'Policy Number',
          orElse: () => ValueObject(title: '', value: ''),
        );
        final nameValue = applicationValues.firstWhere(
          (value) => value.title == 'Name',
          orElse: () => ValueObject(title: '', value: ''),
        );

        // Create a new ValueObject with the Policy Number and Name
        final cardValue = ValueObject(
          title: policyNumberValue.value,
          value: nameValue.value,
          icon: FontAwesomeIcons.hashtag, // Use an appropriate icon
        );

        values.add(cardValue);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        title: "Filled Applications",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: values.length,
          itemBuilder: (context, index) {
            final value = values[index];
            return FilledApplicationCard(
                policyNumber: value.title, name: value.value);
          },
        ),
      ),
    );
  }
}

// IconData iconDataFromString(String iconString) {
//   int codePoint = int.parse(iconString, radix: 16);
//   return IconData(codePoint, fontFamily: 'FontAwesome');
// }
