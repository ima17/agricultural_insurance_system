import 'dart:convert';

import 'package:agricultural_insurance_system/screens/home_screen.dart';
import 'package:agricultural_insurance_system/widgets/button_widget.dart';
import 'package:agricultural_insurance_system/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/application_data.dart';
import '../models/district_data.dart';
import '../models/flood_risk_data.dart';
import '../models/prediction_data.dart';
import '../models/value_object_data.dart';
import '../models/whether_risk_data.dart';
import '../widgets/custom_app_bar.dart';

class ResultScreen extends StatefulWidget {
  final PredictionData? predictionData;
  final ApplicationData? applicationData;
  final DistrictData? districtData;
  final WeatherRiskData? weatherRiskData;
  final FloodRiskData? floodRiskData;

  const ResultScreen({
    Key? key,
    required this.applicationData,
    required this.districtData,
    required this.weatherRiskData,
    required this.floodRiskData,
    required this.predictionData,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late String policyNumber;

  List<ValueObject> values = [];

  @override
  void initState() {
    policyNumber = generatePolicyNumber();

    values = [
      ValueObject(
        title: 'Policy Number',
        value: policyNumber,
        icon: FontAwesomeIcons.hashtag,
      ),
      ValueObject(
        title: 'Name',
        value: widget.applicationData!.name,
        icon: FontAwesomeIcons.user,
      ),
      ValueObject(
        title: 'Address',
        value: widget.applicationData!.address,
        icon: FontAwesomeIcons.addressBook,
      ),
      ValueObject(
        title: 'Date of Birth',
        value: widget.applicationData!.dateOfBirth,
        icon: FontAwesomeIcons.calendar,
      ),
      ValueObject(
        title: 'NIC Number',
        value: widget.applicationData!.contactNumber,
        icon: FontAwesomeIcons.idCard,
      ),
      ValueObject(
        title: 'Season',
        value: widget.applicationData!.occupation,
        icon: FontAwesomeIcons.snowflake,
      ),
      ValueObject(
        title: 'Cultivaion Method',
        value: widget.applicationData!.age,
        icon: FontAwesomeIcons.seedling,
      ),
      ValueObject(
        title: 'Paddy Type',
        value: widget.applicationData!.gender,
        icon: FontAwesomeIcons.leaf,
      ),
      ValueObject(
        title: 'Land Size',
        value: widget.applicationData!.propertySize,
        icon: FontAwesomeIcons.ruler,
      ),
      ValueObject(
        title: 'GND',
        value: widget.districtData!.gnd,
        icon: FontAwesomeIcons.locationDot,
      ),
      ValueObject(
        title: 'District',
        value: widget.districtData!.district,
        icon: FontAwesomeIcons.mapLocationDot,
      ),
      ValueObject(
        title: 'Flood Risk',
        value: widget.floodRiskData!.floodRisk,
        icon: FontAwesomeIcons.accusoft,
      ),
      ValueObject(
        title: 'Weather Risk',
        value: widget.weatherRiskData!.weatherRisk,
        icon: FontAwesomeIcons.cloudSunRain,
      ),
      ValueObject(
        title: 'Premium Rate',
        value: double.parse(widget.predictionData!.premiumRate)
                .toStringAsFixed(2) +
            ' %',
        icon: FontAwesomeIcons.dollarSign,
      ),
      ValueObject(
        title: 'Given Sum Assured',
        value: 'Rs.' +
            double.parse(widget.predictionData!.givenSumAssured)
                .toStringAsFixed(0),
        icon: FontAwesomeIcons.fileInvoiceDollar,
      ),
      ValueObject(
        title: 'Monthly Premium',
        value: 'Rs.' +
            double.parse(widget.predictionData!.monthlyPremium)
                .toStringAsFixed(0),
        icon: FontAwesomeIcons.coins,
      ),
    ];

    super.initState();
  }

  String generatePolicyNumber() {
    final faker = Faker();
    return faker.randomGenerator.integer(999999).toString().padLeft(6, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(elevation: 0, title: 'Information'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: values.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final title = values[index].title;
                    final value = values[index].value;
                    final icon = values[index].icon;

                    return InfoCard(
                      icon: icon!,
                      infoTitle: title,
                      info: value,
                    );
                  },
                ),
              ),
            ),
            ButtonWidget(
              buttonText: "Save and Return to Home",
              buttonTriggerFunction: () async {
                final jsonValue =
                    values.map((value) => value.toJson()).toList();
                final jsonString = jsonEncode(jsonValue);

                // Generate a unique identifier for the current application
                final uniqueId =
                    DateTime.now().millisecondsSinceEpoch.toString();

                // Save the JSON string to local storage with the unique identifier
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('values_$uniqueId', jsonString);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

String iconDataSolidToString(IconDataSolid iconDataSolid) {
  return String.fromCharCode(iconDataSolid.codePoint);
}
