import 'package:agricultural_insurance_system/constants/url_links.dart';
import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:agricultural_insurance_system/models/district_data.dart';
import 'package:agricultural_insurance_system/models/flood_risk_data.dart';
import 'package:agricultural_insurance_system/models/whether_risk_data.dart';
import 'package:agricultural_insurance_system/screens/prediction_screen.dart';
import 'package:agricultural_insurance_system/screens/risks_show_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:charts_flutter/flutter.dart' as charts;

import 'risks_show_screen.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final String value;

  ProgressIndicatorWidget({required this.value});

  @override
  Widget build(BuildContext context) {
    Color progressColor;
    double progressValue;

    switch (value) {
      case 'No':
        progressColor = Colors.green;
        progressValue = 0.2;
        break;
      case 'Moderate':
        progressColor = Color.fromARGB(255, 212, 171, 36);
        progressValue = 0.55;
        break;
      case 'High':
        progressColor = Colors.red;
        progressValue = 0.95;
        break;
      default:
        progressColor = Colors.transparent;
        progressValue = 0.0;
    }

    return SizedBox(
      height: 30, // Set the desired height
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(20), // Set the desired border radius
        child: LinearProgressIndicator(
          value: progressValue,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        ),
      ),
    );
  }
}

class RiskShowScreen extends StatefulWidget {
  final ApplicationData? applicationData;
  final LatLng currentPosition;

  const RiskShowScreen({
    Key? key,
    this.applicationData,
    required this.currentPosition,
  }) : super(key: key);

  @override
  State<RiskShowScreen> createState() => _RiskShowScreenState();
}

class _RiskShowScreenState extends State<RiskShowScreen> {
  DistrictData? districtData;
  FloodRiskData? floodRiskData;
  WeatherRiskData? weatherRiskData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    print(
        'Latitude: ${widget.currentPosition.latitude}, Longitude: ${widget.currentPosition.latitude}');

    final headers = {'Content-Type': 'application/json'};
    final requestBody1 = {
      'lat': widget.currentPosition.latitude,
      'lon': widget.currentPosition.longitude,
    };
    final requestBody2 = {
      'lat': widget.currentPosition.latitude,
      'lon': widget.currentPosition.longitude,
      'season': widget.applicationData!.occupation,
    };

    try {
      final response1 = await http.post(Uri.parse(admBoundryLink),
          headers: headers, body: jsonEncode(requestBody1));

      if (response1.statusCode == 200) {
        // Request 1 successful, handle the response here
        print('API 1 response: ${response1.body}');
        districtData = DistrictData.fromJson(jsonDecode(response1.body));

        final response2 = await http.post(Uri.parse(floodRiskLink),
            headers: headers, body: jsonEncode(requestBody2));

        if (response2.statusCode == 200) {
          // Request 2 successful, handle the response here
          print('API 2 response: ${response2.body}');
          floodRiskData = FloodRiskData.fromJson(jsonDecode(response2.body));

          // Extract the necessary value from response 1 and assign it to request body 3
          final valueFromResponse1 = districtData?.district;
          final requestBody3 = {
            'location': valueFromResponse1,
            'year': 2011,
            'season': widget.applicationData!.occupation
          };

          final response3 = await http.post(Uri.parse(weatherRiskLink),
              headers: headers, body: jsonEncode(requestBody3));

          if (response3.statusCode == 200) {
            // Request 3 successful, handle the response here
            print('API 3 response: ${response3.body}');
            weatherRiskData =
                WeatherRiskData.fromJson(jsonDecode(response3.body));
          } else {
            // Request 3 failed, handle the error
            print(
                'API request 3 failed with status code ${response3.statusCode}');
          }
        } else {
          // Request 2 failed, handle the error
          print(
              'API request 2 failed with status code ${response2.statusCode}');
        }
      } else {
        // Request 1 failed, handle the error
        print('API request 1 failed with status code ${response1.statusCode}');
      }
    } catch (error) {
      // An error occurred while making the request
      print('Error making API request: $error');
    }

    setState(() {
      isLoading = false; // Set isLoading to false after receiving the data
    });
  }

  get floodRisk => floodRiskData!.floodRisk;
  get weatherRisk => weatherRiskData!.weatherRisk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Risk Details'),
      ),
      body: Center(
        child: isLoading
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Calculating Risks',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // First Section: Location Details
                    Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location Details',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          if (districtData != null)
                            Table(
                              border: TableBorder.all(
                                  color: Colors.black, width: 1.0),
                              columnWidths: const {
                                0: FlexColumnWidth(),
                                1: FlexColumnWidth(),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255)),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'District',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'GN Division',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        districtData!.district,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        districtData!.gnd,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 36),
                    Divider(), // Add divider between sections
                    SizedBox(height: 36),
                    // Second Section: Risk Levels
                    Container(
                      color: Color.fromARGB(255, 255, 255, 255),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Risk Levels',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          //progress bar
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              'Flood Risk: $floodRisk',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ProgressIndicatorWidget(value: floodRisk),
                          SizedBox(height: 42),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              'Weather Risk: $weatherRisk',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          ProgressIndicatorWidget(value: weatherRisk),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PredictionScreen(
                applicationData: widget.applicationData,
                districtData: districtData,
                weatherRiskData: weatherRiskData,
                floodRiskData: floodRiskData,
              ),
            ),
          );
        },
        child: const Text(
          'Save and Next',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
    
    
  }
}












