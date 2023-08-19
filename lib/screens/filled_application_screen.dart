import 'dart:convert';

import 'package:agricultural_insurance_system/configs/palette.dart';
import 'package:agricultural_insurance_system/widgets/custom_app_bar.dart';
import 'package:agricultural_insurance_system/widgets/filled_application_card.dart';
import 'package:agricultural_insurance_system/widgets/input_widget.dart';
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
  List<ValueObject> filteredValues = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    retrieveValues();
  }

  Future<void> retrieveValues() async {
    final prefs = await SharedPreferences.getInstance();

    final keys = prefs.getKeys();
    final applicationKeys = keys.where((key) => key.startsWith('values_'));

    values = [];
    for (final key in applicationKeys) {
      final jsonString = prefs.getString(key);
      if (jsonString != null) {
        final jsonValues = jsonDecode(jsonString) as List<dynamic>;
        final applicationValues = jsonValues
            .map((jsonValue) => ValueObject.fromJson(jsonValue))
            .toList();

        final policyNumberValue = applicationValues.firstWhere(
          (value) => value.title == 'Policy Number',
          orElse: () => ValueObject(title: '', value: ''),
        );
        final nameValue = applicationValues.firstWhere(
          (value) => value.title == 'Name',
          orElse: () => ValueObject(title: '', value: ''),
        );

        final cardValue = ValueObject(
          title: policyNumberValue.value,
          value: nameValue.value,
          icon: FontAwesomeIcons.hashtag,
          originalObject: applicationValues,
        );

        values.add(cardValue);
      }
    }

    // Initialize filteredValues with all values
    filteredValues = List.from(values);

    setState(() {});
  }

  void filterValues() {
    filteredValues = values.where((valueObject) {
      final title = valueObject.title.toLowerCase();
      final value = valueObject.value.toLowerCase();
      final query = searchQuery.toLowerCase();

      return title.contains(query) || value.contains(query);
    }).toList();
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
        child: Column(
          children: [
            InputWidget(
              inputPlaceholder: 'Search',
              trailingIcon: Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 15,
                color: Palette.kPrimaryColor,
              ),
              inputTriggerFunction: (value) {
                setState(() {
                  searchQuery = value;
                  filterValues();
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredValues.length,
                itemBuilder: (context, index) {
                  final valueObject = filteredValues[index];
                  return FilledApplicationCard(valueObject: valueObject);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
