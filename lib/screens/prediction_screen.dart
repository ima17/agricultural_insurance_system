import 'dart:convert';

import 'package:agricultural_insurance_system/constants/url_links.dart';
import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:agricultural_insurance_system/models/district_data.dart';
import 'package:agricultural_insurance_system/models/flood_risk_data.dart';
import 'package:agricultural_insurance_system/models/prediction_data.dart';
import 'package:agricultural_insurance_system/models/whether_risk_data.dart';
import 'package:agricultural_insurance_system/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictionScreen extends StatefulWidget {
  final ApplicationData? applicationData;
  final DistrictData? districtData;
  final WeatherRiskData? weatherRiskData;
  final FloodRiskData? floodRiskData;

  const PredictionScreen({
    Key? key,
    required this.applicationData,
    required this.districtData,
    required this.weatherRiskData,
    required this.floodRiskData,
  }) : super(key: key);

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  PredictionData? predictionData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const url = premiumLink;

    final requestBody = {
      'gnd': widget.districtData!.gnd,
      'district': widget.districtData!.district,
      'method': widget.applicationData!.age,
      'season': widget.applicationData!.occupation,
      'paddy_type': 3,
      'flood_risk': widget.floodRiskData!.floodRisk,
      'weather_risk': widget.weatherRiskData!.weatherRisk,
      'land_size': 1.5,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        predictionData = PredictionData.fromJson(jsonResponse);
        isLoading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predicted Premium'),
      ),
      body: Center(
        child: isLoading
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Predicting the Premium',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (predictionData != null)
                    Text(
                      'Premium Rate: ${predictionData!.premiumRate}',
                      style: const TextStyle(fontSize: 24),
                    ),
                  if (predictionData != null)
                    Text(
                      'Given Sum Assured: ${predictionData!.givenSumAssured}',
                      style: const TextStyle(fontSize: 24),
                    ),
                  if (predictionData != null)
                    Text(
                      'Monthly Premium: ${predictionData!.monthlyPremium}',
                      style: const TextStyle(fontSize: 24),
                    ),
                ],
              ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                applicationData: widget.applicationData,
                districtData: widget.districtData,
                weatherRiskData: widget.weatherRiskData,
                floodRiskData: widget.floodRiskData,
                predictionData: predictionData,
              ),
            ),
          );
        },
        child: const Text(
          'Show Results',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
