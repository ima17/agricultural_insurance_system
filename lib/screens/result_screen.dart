import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import '../models/application_data.dart';
import '../models/district_data.dart';
import '../models/flood_risk_data.dart';
import '../models/prediction_data.dart';
import '../models/whether_risk_data.dart';
import 'recording_screen.dart';

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

  List<Map<String, String>> values = [];

  @override
  void initState() {
    policyNumber = generatePolicyNumber();

    values = [
      {'Policy Number': policyNumber},
      {'Name': widget.applicationData!.name},
      {'Address': widget.applicationData!.address},
      {'Date of Birth': widget.applicationData!.dateOfBirth},
      {'NIC Number': widget.applicationData!.contactNumber},
      {'Season': widget.applicationData!.occupation},
      {'Cultivaion Method': widget.applicationData!.age},
      {'Paddy Type': widget.applicationData!.gender},
      {'Land Size': widget.applicationData!.propertySize},
      {'GND': widget.districtData!.gnd},
      {'District': widget.districtData!.district},
      {'Flood Risk': widget.floodRiskData!.floodRisk},
      {'Weather Risk': widget.weatherRiskData!.weatherRisk},
      {'Premium Rate': widget.predictionData!.premiumRate},
      {'Given Sum Assured': widget.predictionData!.givenSumAssured},
      {'Monthly Premium': widget.predictionData!.monthlyPremium},
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
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: values.map((value) {
                    return TableRow(
                      children: value.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.key,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                entry.value,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecordingScreen()),
                );
              },
              icon: const Icon(Icons.home),
              label: const Text('Finish and Return to Home'),
            ),
          ),
        ],
      ),
    );
  }
}
